"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const child_process = require("child_process");
const fs = require("fs");
const path = require("path");
const util_1 = require("util");
const vs = require("vscode");
const lc = require("vscode-languageclient");
const signatureHelpProvider_1 = require("./providers/signatureHelpProvider");
const rustup_1 = require("./rustup");
const exec = util_1.promisify(child_process.exec);
/** Rustup components required for the RLS to work correctly. */
const REQUIRED_COMPONENTS = ['rust-analysis', 'rust-src', 'rls'];
/**
 * VSCode settings to be observed and sent to RLS whenever they change.
 * Previously we just used 'rust' but since RLS warns against unrecognized
 * options and because we want to unify the options behind a single 'rust'
 * namespace for both client/server configuration, we explicitly list the
 * settings previously sent to the RLS.
 * TODO: Replace RLS' configuration setup with workspace/configuration request.
 */
const OBSERVED_SETTINGS = [
    'rust.sysroot',
    'rust.target',
    'rust.rustflags',
    'rust.clear_env_rust_log',
    'rust.build_lib',
    'rust.build_bin',
    'rust.cfg_test',
    'rust.unstable_features',
    'rust.wait_to_build',
    'rust.show_warnings',
    'rust.crate_blacklist',
    'rust.build_on_save',
    'rust.features',
    'rust.all_features',
    'rust.no_default_features',
    'rust.racer_completion',
    'rust.clippy_preference',
    'rust.jobs',
    'rust.all_targets',
    'rust.target_dir',
    'rust.rustfmt_path',
    'rust.build_command',
    'rust.full_docs',
    'rust.show_hover_context',
];
function createLanguageClient(folder, config) {
    const serverOptions = () => __awaiter(this, void 0, void 0, function* () {
        if (config.updateOnStartup && !config.rustup.disabled) {
            yield rustup_1.rustupUpdate(config.rustup);
        }
        return makeRlsProcess(config.rustup, {
            path: config.rls.path,
            cwd: folder.uri.fsPath,
        }, { logToFile: config.logToFile });
    });
    const clientOptions = {
        // Register the server for Rust files
        documentSelector: [
            { language: 'rust', scheme: 'untitled' },
            documentFilter(folder),
        ],
        diagnosticCollectionName: `rust-${folder.uri}`,
        synchronize: { configurationSection: OBSERVED_SETTINGS },
        // Controls when to focus the channel rather than when to reveal it in the drop-down list
        revealOutputChannelOn: config.revealOutputChannelOn,
        initializationOptions: {
            omitInitBuild: true,
            cmdRun: true,
        },
        workspaceFolder: folder,
    };
    return new lc.LanguageClient('rust-client', 'Rust Language Server', serverOptions, clientOptions);
}
exports.createLanguageClient = createLanguageClient;
function setupClient(client, folder) {
    return [
        vs.languages.registerSignatureHelpProvider(documentFilter(folder), new signatureHelpProvider_1.SignatureHelpProvider(client), '(', ','),
    ];
}
exports.setupClient = setupClient;
function setupProgress(client, observableProgress) {
    const runningProgress = new Set();
    // We can only register notification handler after the client is ready
    client.onReady().then(() => client.onNotification(new lc.NotificationType('window/progress'), progress => {
        if (progress.done) {
            runningProgress.delete(progress.id);
        }
        else {
            runningProgress.add(progress.id);
        }
        if (runningProgress.size) {
            let status = '';
            if (typeof progress.percentage === 'number') {
                status = `${Math.round(progress.percentage * 100)}%`;
            }
            else if (progress.message) {
                status = progress.message;
            }
            else if (progress.title) {
                status = `[${progress.title.toLowerCase()}]`;
            }
            observableProgress.value = { state: 'progress', message: status };
        }
        else {
            observableProgress.value = { state: 'ready' };
        }
    }));
}
exports.setupProgress = setupProgress;
function documentFilter(folder) {
    // This accepts `vscode.GlobPattern` under the hood, which requires only
    // forward slashes. It's worth mentioning that RelativePattern does *NOT*
    // work in remote scenarios (?), so rely on normalized fs path from VSCode URIs.
    const pattern = `${folder.uri.fsPath.replace(path.sep, '/')}/**`;
    return { language: 'rust', scheme: 'file', pattern };
}
function getSysroot(rustup, env) {
    return __awaiter(this, void 0, void 0, function* () {
        const printSysrootCmd = rustup.disabled
            ? 'rustc --print sysroot'
            : `${rustup.path} run ${rustup.channel} rustc --print sysroot`;
        const { stdout } = yield exec(printSysrootCmd, { env });
        return stdout.toString().trim();
    });
}
// Make an evironment to run the RLS.
function makeRlsEnv(rustup, opts = {
    setLibPath: false,
}) {
    return __awaiter(this, void 0, void 0, function* () {
        // Shallow clone, we don't want to modify this process' $PATH or
        // $(DY)LD_LIBRARY_PATH
        const env = Object.assign({}, process.env);
        let sysroot;
        try {
            sysroot = yield getSysroot(rustup, env);
        }
        catch (err) {
            console.info(err.message);
            console.info(`Let's retry with extended $PATH`);
            env.PATH = `${env.HOME || '~'}/.cargo/bin:${env.PATH || ''}`;
            try {
                sysroot = yield getSysroot(rustup, env);
            }
            catch (e) {
                console.warn('Error reading sysroot (second try)', e);
                vs.window.showWarningMessage(`Error reading sysroot: ${e.message}`);
                return env;
            }
        }
        console.info(`Setting sysroot to`, sysroot);
        if (opts.setLibPath) {
            function appendEnv(envVar, newComponent) {
                const old = process.env[envVar];
                return old ? `${newComponent}:${old}` : newComponent;
            }
            const newComponent = path.join(sysroot, 'lib');
            env.DYLD_LIBRARY_PATH = appendEnv('DYLD_LIBRARY_PATH', newComponent);
            env.LD_LIBRARY_PATH = appendEnv('LD_LIBRARY_PATH', newComponent);
        }
        return env;
    });
}
function makeRlsProcess(rustup, rls, options = {}) {
    var _a;
    return __awaiter(this, void 0, void 0, function* () {
        // Run "rls" from the PATH unless there's an override.
        const rlsPath = rls.path || 'rls';
        const cwd = rls.cwd;
        let childProcess;
        if (rustup.disabled) {
            console.info(`running without rustup: ${rlsPath}`);
            // Set [DY]LD_LIBRARY_PATH ourselves, since that's usually done automatically
            // by rustup when it chooses a toolchain
            const env = yield makeRlsEnv(rustup, { setLibPath: true });
            childProcess = child_process.spawn(rlsPath, [], {
                env,
                cwd,
                shell: true,
            });
        }
        else {
            console.info(`running with rustup: ${rlsPath}`);
            const config = rustup;
            yield rustup_1.ensureToolchain(config);
            if (!rls.path) {
                // We only need a rustup-installed RLS if we weren't given a
                // custom RLS path.
                console.info('will use a rustup-installed RLS; ensuring present');
                yield rustup_1.ensureComponents(config, REQUIRED_COMPONENTS);
            }
            const env = yield makeRlsEnv(rustup, { setLibPath: false });
            childProcess = child_process.spawn(config.path, ['run', config.channel, rlsPath], { env, cwd, shell: true });
        }
        childProcess.on('error', (err) => {
            if (err.code === 'ENOENT') {
                console.error(`Could not spawn RLS: ${err.message}`);
                vs.window.showWarningMessage(`Could not spawn RLS: \`${err.message}\``);
            }
        });
        if (options.logToFile) {
            const logPath = path.join(rls.cwd, `rls${Date.now()}.log`);
            const logStream = fs.createWriteStream(logPath, { flags: 'w+' });
            (_a = childProcess.stderr) === null || _a === void 0 ? void 0 : _a.pipe(logStream);
        }
        return childProcess;
    });
}
//# sourceMappingURL=rls.js.map