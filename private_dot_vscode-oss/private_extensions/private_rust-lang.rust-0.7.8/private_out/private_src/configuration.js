"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const vscode_languageclient_1 = require("vscode-languageclient");
const rustup_1 = require("./rustup");
function fromStringToRevealOutputChannelOn(value) {
    switch (value && value.toLowerCase()) {
        case 'info':
            return vscode_languageclient_1.RevealOutputChannelOn.Info;
        case 'warn':
            return vscode_languageclient_1.RevealOutputChannelOn.Warn;
        case 'error':
            return vscode_languageclient_1.RevealOutputChannelOn.Error;
        case 'never':
        default:
            return vscode_languageclient_1.RevealOutputChannelOn.Never;
    }
}
class RLSConfiguration {
    constructor(configuration, wsPath) {
        this.configuration = configuration;
        this.wsPath = wsPath;
    }
    static loadFromWorkspace(wsPath) {
        const configuration = vscode_1.workspace.getConfiguration();
        return new RLSConfiguration(configuration, wsPath);
    }
    static readRevealOutputChannelOn(configuration) {
        const setting = configuration.get('rust-client.revealOutputChannelOn', 'never');
        return fromStringToRevealOutputChannelOn(setting);
    }
    /**
     * Tries to fetch the `rust-client.channel` configuration value. If missing,
     * falls back on active toolchain specified by rustup (at `rustupPath`),
     * finally defaulting to `nightly` if all fails.
     */
    static readChannel(wsPath, rustupPath, configuration) {
        const channel = configuration.get('rust-client.channel');
        if (channel === 'default' || !channel) {
            try {
                return rustup_1.getActiveChannel(wsPath, rustupPath);
            }
            catch (e) {
                // rustup might not be installed at the time the configuration is
                // initially loaded, so silently ignore the error and return a default value
                return 'nightly';
            }
        }
        else {
            return channel;
        }
    }
    get rustupPath() {
        return this.configuration.get('rust-client.rustupPath', 'rustup');
    }
    get logToFile() {
        return this.configuration.get('rust-client.logToFile', false);
    }
    get rustupDisabled() {
        const rlsOverriden = Boolean(this.rlsPath);
        return (rlsOverriden ||
            this.configuration.get('rust-client.disableRustup', false));
    }
    get rustAnalyzer() {
        const cfg = this.configuration;
        const releaseTag = cfg.get('rust.rust-analyzer.releaseTag', 'nightly');
        const path = cfg.get('rust.rust-analyzer.path');
        return Object.assign({ releaseTag }, { path });
    }
    get revealOutputChannelOn() {
        return RLSConfiguration.readRevealOutputChannelOn(this.configuration);
    }
    get updateOnStartup() {
        return this.configuration.get('rust-client.updateOnStartup', true);
    }
    get channel() {
        return RLSConfiguration.readChannel(this.wsPath, this.rustupPath, this.configuration);
    }
    /**
     * If specified, RLS will be spawned by executing a file at the given path.
     */
    get rlsPath() {
        return this.configuration.get('rust-client.rlsPath');
    }
    /** Returns the language analysis engine to be used for the workspace */
    get engine() {
        return this.configuration.get('rust-client.engine') || 'rls';
    }
    /**
     * Whether a language server should be automatically started when opening
     * a relevant Rust project.
     */
    get autoStartRls() {
        return this.configuration.get('rust-client.autoStartRls', true);
    }
    rustupConfig() {
        return {
            channel: this.channel,
            path: this.rustupPath,
        };
    }
}
exports.RLSConfiguration = RLSConfiguration;
//# sourceMappingURL=configuration.js.map