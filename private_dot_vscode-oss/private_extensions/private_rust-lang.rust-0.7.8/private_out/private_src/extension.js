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
const vscode_1 = require("vscode");
const lc = require("vscode-languageclient");
const configuration_1 = require("./configuration");
const rls = require("./rls");
const rustAnalyzer = require("./rustAnalyzer");
const rustup_1 = require("./rustup");
const spinner_1 = require("./spinner");
const tasks_1 = require("./tasks");
const observable_1 = require("./utils/observable");
const workspace_1 = require("./utils/workspace");
function activate(context) {
    return __awaiter(this, void 0, void 0, function* () {
        context.subscriptions.push(...[
            configureLanguage(),
            ...registerCommands(),
            vscode_1.workspace.onDidChangeWorkspaceFolders(whenChangingWorkspaceFolders),
            vscode_1.window.onDidChangeActiveTextEditor(onDidChangeActiveTextEditor),
        ]);
        // Manually trigger the first event to start up server instance if necessary,
        // since VSCode doesn't do that on startup by itself.
        onDidChangeActiveTextEditor(vscode_1.window.activeTextEditor);
        // Migrate the users of multi-project setup for RLS to disable the setting
        // entirely (it's always on now)
        const config = vscode_1.workspace.getConfiguration();
        if (typeof config.get('rust-client.enableMultiProjectSetup', null) === 'boolean') {
            vscode_1.window
                .showWarningMessage('The multi-project setup for RLS is always enabled, so the `rust-client.enableMultiProjectSetup` setting is now redundant', { modal: false }, { title: 'Remove' })
                .then(value => {
                if (value && value.title === 'Remove') {
                    return config.update('rust-client.enableMultiProjectSetup', null, vscode_1.ConfigurationTarget.Global);
                }
                return;
            });
        }
        return { activeWorkspace };
    });
}
exports.activate = activate;
function deactivate() {
    return __awaiter(this, void 0, void 0, function* () {
        return Promise.all([...workspaces.values()].map(ws => ws.stop()));
    });
}
exports.deactivate = deactivate;
/** Tracks dynamically updated progress for the active client workspace for UI purposes. */
let progressObserver;
function onDidChangeActiveTextEditor(editor) {
    if (!editor || !editor.document) {
        return;
    }
    const { languageId, uri } = editor.document;
    const workspace = clientWorkspaceForUri(uri, {
        initializeIfMissing: languageId === 'rust' || languageId === 'toml',
    });
    if (!workspace) {
        return;
    }
    activeWorkspace.value = workspace;
    const updateProgress = (progress) => {
        if (progress.state === 'progress') {
            spinner_1.startSpinner(`[${workspace.folder.name}] ${progress.message}`);
        }
        else {
            const readySymbol = progress.state === 'standby' ? '$(debug-stop)' : '$(debug-start)';
            spinner_1.stopSpinner(`[${workspace.folder.name}] ${readySymbol}`);
        }
    };
    if (progressObserver) {
        progressObserver.dispose();
    }
    progressObserver = workspace.progress.observe(updateProgress);
    // Update UI ourselves immediately and don't wait for value update callbacks
    updateProgress(workspace.progress.value);
}
function whenChangingWorkspaceFolders(e) {
    // If a workspace is removed which is a Rust workspace, kill the client.
    for (const folder of e.removed) {
        const ws = workspaces.get(folder.uri.toString());
        if (ws) {
            workspaces.delete(folder.uri.toString());
            ws.stop();
        }
    }
}
// Don't use URI as it's unreliable the same path might not become the same URI.
const workspaces = new Map();
/**
 * Fetches a `ClientWorkspace` for a given URI. If missing and `initializeIfMissing`
 * option was provided, it is additionally initialized beforehand, if applicable.
 */
function clientWorkspaceForUri(uri, options) {
    const rootFolder = vscode_1.workspace.getWorkspaceFolder(uri);
    if (!rootFolder) {
        return;
    }
    const folder = workspace_1.nearestParentWorkspace(rootFolder, uri.fsPath);
    if (!folder) {
        return undefined;
    }
    const existing = workspaces.get(folder.uri.toString());
    if (!existing && options && options.initializeIfMissing) {
        const workspace = new ClientWorkspace(folder);
        workspaces.set(folder.uri.toString(), workspace);
        workspace.autoStart();
    }
    return workspaces.get(folder.uri.toString());
}
// We run a single server/client pair per workspace folder (VSCode workspace,
// not Cargo workspace). This class contains all the per-client and
// per-workspace stuff.
class ClientWorkspace {
    constructor(folder) {
        this.lc = null;
        this.config = configuration_1.RLSConfiguration.loadFromWorkspace(folder.uri.fsPath);
        this.folder = folder;
        this.disposables = [];
        this._progress = new observable_1.Observable({ state: 'standby' });
    }
    get progress() {
        return this._progress;
    }
    /**
     * Attempts to start a server instance, if not configured otherwise via
     * applicable `rust-client.autoStartRls` setting.
     * @returns whether the server has started.
     */
    autoStart() {
        return __awaiter(this, void 0, void 0, function* () {
            return this.config.autoStartRls && this.start().then(() => true);
        });
    }
    start() {
        return __awaiter(this, void 0, void 0, function* () {
            const { createLanguageClient, setupClient, setupProgress } = this.config.engine === 'rls' ? rls : rustAnalyzer;
            const client = yield createLanguageClient(this.folder, {
                updateOnStartup: this.config.updateOnStartup,
                revealOutputChannelOn: this.config.revealOutputChannelOn,
                logToFile: this.config.logToFile,
                rustup: {
                    channel: this.config.channel,
                    path: this.config.rustupPath,
                    disabled: this.config.rustupDisabled,
                },
                rls: { path: this.config.rlsPath },
                rustAnalyzer: this.config.rustAnalyzer,
            });
            client.onDidChangeState(({ newState }) => {
                if (newState === lc.State.Starting) {
                    this._progress.value = { state: 'progress', message: 'Starting' };
                }
                if (newState === lc.State.Stopped) {
                    this._progress.value = { state: 'standby' };
                }
            });
            setupProgress(client, this._progress);
            this.disposables.push(tasks_1.activateTaskProvider(this.folder));
            this.disposables.push(...setupClient(client, this.folder));
            if (client.needsStart()) {
                this.disposables.push(client.start());
            }
        });
    }
    stop() {
        return __awaiter(this, void 0, void 0, function* () {
            if (this.lc) {
                yield this.lc.stop();
            }
            this.disposables.forEach(d => d.dispose());
        });
    }
    restart() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.stop();
            return this.start();
        });
    }
    runRlsCommand(cmd) {
        return tasks_1.runRlsCommand(this.folder, cmd);
    }
    rustupUpdate() {
        return rustup_1.rustupUpdate(this.config.rustupConfig());
    }
}
exports.ClientWorkspace = ClientWorkspace;
/**
 * Tracks the most current VSCode workspace as opened by the user. Used by the
 * commands to know in which workspace these should be executed.
 */
const activeWorkspace = new observable_1.Observable(null);
/**
 * Registers the VSCode [commands] used by the extension.
 *
 * [commands]: https://code.visualstudio.com/api/extension-guides/command
 */
function registerCommands() {
    return [
        vscode_1.commands.registerCommand('rls.update', () => { var _a; return (_a = activeWorkspace.value) === null || _a === void 0 ? void 0 : _a.rustupUpdate(); }),
        vscode_1.commands.registerCommand('rls.restart', () => __awaiter(this, void 0, void 0, function* () { var _a; return (_a = activeWorkspace.value) === null || _a === void 0 ? void 0 : _a.restart(); })),
        vscode_1.commands.registerCommand('rls.run', (cmd) => { var _a; return (_a = activeWorkspace.value) === null || _a === void 0 ? void 0 : _a.runRlsCommand(cmd); }),
        vscode_1.commands.registerCommand('rls.start', () => { var _a; return (_a = activeWorkspace.value) === null || _a === void 0 ? void 0 : _a.start(); }),
        vscode_1.commands.registerCommand('rls.stop', () => { var _a; return (_a = activeWorkspace.value) === null || _a === void 0 ? void 0 : _a.stop(); }),
    ];
}
/**
 * Sets up additional language configuration that's impossible to do via a
 * separate language-configuration.json file. See [1] for more information.
 *
 * [1]: https://github.com/Microsoft/vscode/issues/11514#issuecomment-244707076
 */
function configureLanguage() {
    return vscode_1.languages.setLanguageConfiguration('rust', {
        onEnterRules: [
            {
                // Doc single-line comment
                // e.g. ///|
                beforeText: /^\s*\/{3}.*$/,
                action: { indentAction: vscode_1.IndentAction.None, appendText: '/// ' },
            },
            {
                // Parent doc single-line comment
                // e.g. //!|
                beforeText: /^\s*\/{2}\!.*$/,
                action: { indentAction: vscode_1.IndentAction.None, appendText: '//! ' },
            },
            {
                // Begins an auto-closed multi-line comment (standard or parent doc)
                // e.g. /** | */ or /*! | */
                beforeText: /^\s*\/\*(\*|\!)(?!\/)([^\*]|\*(?!\/))*$/,
                afterText: /^\s*\*\/$/,
                action: { indentAction: vscode_1.IndentAction.IndentOutdent, appendText: ' * ' },
            },
            {
                // Begins a multi-line comment (standard or parent doc)
                // e.g. /** ...| or /*! ...|
                beforeText: /^\s*\/\*(\*|\!)(?!\/)([^\*]|\*(?!\/))*$/,
                action: { indentAction: vscode_1.IndentAction.None, appendText: ' * ' },
            },
            {
                // Continues a multi-line comment
                // e.g.  * ...|
                beforeText: /^(\ \ )*\ \*(\ ([^\*]|\*(?!\/))*)?$/,
                action: { indentAction: vscode_1.IndentAction.None, appendText: '* ' },
            },
            {
                // Dedents after closing a multi-line comment
                // e.g.  */|
                beforeText: /^(\ \ )*\ \*\/\s*$/,
                action: { indentAction: vscode_1.IndentAction.None, removeText: 1 },
            },
        ],
    });
}
//# sourceMappingURL=extension.js.map