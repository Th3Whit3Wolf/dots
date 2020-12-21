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
const net_1 = require("./net");
const rustup = require("./rustup");
const observable_1 = require("./utils/observable");
const stat = util_1.promisify(fs.stat);
const mkdir = util_1.promisify(fs.mkdir);
const readFile = util_1.promisify(fs.readFile);
const writeFile = util_1.promisify(fs.writeFile);
const REQUIRED_COMPONENTS = ['rust-src'];
/** Returns a path where rust-analyzer should be installed. */
function installDir() {
    if (process.platform === 'linux' || process.platform === 'darwin') {
        // Prefer, in this order:
        // 1. $XDG_BIN_HOME (proposed addition to XDG spec)
        // 2. $XDG_DATA_HOME/../bin/
        // 3. $HOME/.local/bin/
        const { HOME, XDG_DATA_HOME, XDG_BIN_HOME } = process.env;
        if (XDG_BIN_HOME) {
            return path.resolve(XDG_BIN_HOME);
        }
        const baseDir = XDG_DATA_HOME
            ? path.join(XDG_DATA_HOME, '..')
            : HOME && path.join(HOME, '.local');
        return baseDir && path.resolve(path.join(baseDir, 'bin'));
    }
    else if (process.platform === 'win32') {
        // %LocalAppData%\rust-analyzer\
        const { LocalAppData } = process.env;
        return (LocalAppData && path.resolve(path.join(LocalAppData, 'rust-analyzer')));
    }
    return undefined;
}
/** Returns a path where persistent data for rust-analyzer should be installed. */
function metadataDir() {
    if (process.platform === 'linux' || process.platform === 'darwin') {
        // Prefer, in this order:
        // 1. $XDG_CONFIG_HOME/rust-analyzer
        // 2. $HOME/.config/rust-analyzer
        const { HOME, XDG_CONFIG_HOME } = process.env;
        const baseDir = XDG_CONFIG_HOME || (HOME && path.join(HOME, '.config'));
        return baseDir && path.resolve(path.join(baseDir, 'rust-analyzer'));
    }
    else if (process.platform === 'win32') {
        // %LocalAppData%\rust-analyzer\
        const { LocalAppData } = process.env;
        return (LocalAppData && path.resolve(path.join(LocalAppData, 'rust-analyzer')));
    }
    return undefined;
}
function ensureDir(path) {
    return !!path && stat(path).catch(() => mkdir(path, { recursive: true }));
}
function readMetadata() {
    return __awaiter(this, void 0, void 0, function* () {
        const stateDir = metadataDir();
        if (!stateDir) {
            return { kind: 'error', code: 'NotSupported' };
        }
        const filePath = path.join(stateDir, 'metadata.json');
        if (!(yield stat(filePath).catch(() => false))) {
            return { kind: 'error', code: 'FileMissing' };
        }
        const contents = yield readFile(filePath, 'utf8');
        const obj = JSON.parse(contents);
        return typeof obj === 'object' ? obj : {};
    });
}
function writeMetadata(config) {
    return __awaiter(this, void 0, void 0, function* () {
        const stateDir = metadataDir();
        if (!stateDir) {
            return false;
        }
        if (!(yield ensureDir(stateDir))) {
            return false;
        }
        const filePath = path.join(stateDir, 'metadata.json');
        return writeFile(filePath, JSON.stringify(config)).then(() => true);
    });
}
function getServer({ askBeforeDownload, package: pkg, }) {
    return __awaiter(this, void 0, void 0, function* () {
        let binaryName;
        if (process.arch === 'x64' || process.arch === 'ia32') {
            if (process.platform === 'linux') {
                binaryName = 'rust-analyzer-linux';
            }
            if (process.platform === 'darwin') {
                binaryName = 'rust-analyzer-mac';
            }
            if (process.platform === 'win32') {
                binaryName = 'rust-analyzer-windows.exe';
            }
        }
        if (binaryName === undefined) {
            vs.window.showErrorMessage("Unfortunately we don't ship binaries for your platform yet. " +
                'You need to manually clone rust-analyzer repository and ' +
                'run `cargo xtask install --server` to build the language server from sources. ' +
                'If you feel that your platform should be supported, please create an issue ' +
                'about that [here](https://github.com/rust-analyzer/rust-analyzer/issues) and we ' +
                'will consider it.');
            return undefined;
        }
        const dir = installDir();
        if (!dir) {
            return;
        }
        yield ensureDir(dir);
        const metadata = yield readMetadata().catch(() => ({}));
        const dest = path.join(dir, binaryName);
        const exists = yield stat(dest).catch(() => false);
        if (exists && metadata.releaseTag === pkg.releaseTag) {
            return dest;
        }
        if (askBeforeDownload) {
            const userResponse = yield vs.window.showInformationMessage(`${metadata.releaseTag && metadata.releaseTag !== pkg.releaseTag
                ? `You seem to have installed release \`${metadata.releaseTag}\` but requested a different one.`
                : ''}
      Release \`${pkg.releaseTag}\` of rust-analyzer is not installed.\n
      Install to ${dir}?`, 'Download');
            if (userResponse !== 'Download') {
                return dest;
            }
        }
        const release = yield net_1.fetchRelease('rust-analyzer', 'rust-analyzer', pkg.releaseTag);
        const artifact = release.assets.find(asset => asset.name === binaryName);
        if (!artifact) {
            throw new Error(`Bad release: ${JSON.stringify(release)}`);
        }
        yield net_1.download(artifact.browser_download_url, dest, 'Downloading rust-analyzer server', { mode: 0o755 });
        yield writeMetadata({ releaseTag: pkg.releaseTag }).catch(() => {
            vs.window.showWarningMessage(`Couldn't save rust-analyzer metadata`);
        });
        return dest;
    });
}
exports.getServer = getServer;
/**
 * Rust Analyzer does not work in an isolated environment and greedily analyzes
 * the workspaces itself, so make sure to spawn only a single instance.
 */
let INSTANCE;
/**
 * TODO:
 * Global observable progress
 */
const PROGRESS = new observable_1.Observable({ state: 'standby' });
function createLanguageClient(folder, config) {
    return __awaiter(this, void 0, void 0, function* () {
        yield rustup.ensureToolchain(config.rustup);
        yield rustup.ensureComponents(config.rustup, REQUIRED_COMPONENTS);
        if (!config.rustAnalyzer.path) {
            yield getServer({
                askBeforeDownload: true,
                package: { releaseTag: config.rustAnalyzer.releaseTag },
            });
        }
        if (INSTANCE) {
            return INSTANCE;
        }
        const serverOptions = () => __awaiter(this, void 0, void 0, function* () {
            var _a;
            const binPath = config.rustAnalyzer.path ||
                (yield getServer({
                    package: { releaseTag: config.rustAnalyzer.releaseTag },
                }));
            if (!binPath) {
                throw new Error("Couldn't fetch Rust Analyzer binary");
            }
            const childProcess = child_process.exec(binPath);
            if (config.logToFile) {
                const logPath = path.join(folder.uri.fsPath, `ra-${Date.now()}.log`);
                const logStream = fs.createWriteStream(logPath, { flags: 'w+' });
                (_a = childProcess.stderr) === null || _a === void 0 ? void 0 : _a.pipe(logStream);
            }
            return childProcess;
        });
        const clientOptions = {
            // Register the server for Rust files
            documentSelector: [
                { language: 'rust', scheme: 'file' },
                { language: 'rust', scheme: 'untitled' },
            ],
            diagnosticCollectionName: `rust`,
            // synchronize: { configurationSection: 'rust' },
            // Controls when to focus the channel rather than when to reveal it in the drop-down list
            revealOutputChannelOn: config.revealOutputChannelOn,
            // TODO: Support and type out supported settings by the rust-analyzer
            initializationOptions: vs.workspace.getConfiguration('rust.rust-analyzer'),
        };
        INSTANCE = new lc.LanguageClient('rust-client', 'Rust Analyzer', serverOptions, clientOptions);
        // Enable semantic highlighting which is available in stable VSCode
        INSTANCE.registerProposedFeatures();
        // We can install only one progress handler so make sure to do that when
        // setting up the singleton instance
        setupGlobalProgress(INSTANCE);
        return INSTANCE;
    });
}
exports.createLanguageClient = createLanguageClient;
function setupGlobalProgress(client) {
    return __awaiter(this, void 0, void 0, function* () {
        client.onDidChangeState(({ newState }) => __awaiter(this, void 0, void 0, function* () {
            if (newState === lc.State.Starting) {
                yield client.onReady();
                const RUST_ANALYZER_PROGRESS = 'rustAnalyzer/startup';
                client.onProgress(new lc.ProgressType(), RUST_ANALYZER_PROGRESS, ({ kind, message: msg }) => {
                    if (kind === 'report') {
                        PROGRESS.value = { state: 'progress', message: msg || '' };
                    }
                    if (kind === 'end') {
                        PROGRESS.value = { state: 'ready' };
                    }
                });
            }
        }));
    });
}
function setupClient(_client, _folder) {
    return [];
}
exports.setupClient = setupClient;
function setupProgress(_client, workspaceProgress) {
    workspaceProgress.value = PROGRESS.value;
    // We can only ever install one progress handler per language client and since
    // we can only ever have one instance of Rust Analyzer, fake the global
    // progress as a workspace one.
    PROGRESS.observe(progress => {
        workspaceProgress.value = progress;
    });
}
exports.setupProgress = setupProgress;
//# sourceMappingURL=rustAnalyzer.js.map