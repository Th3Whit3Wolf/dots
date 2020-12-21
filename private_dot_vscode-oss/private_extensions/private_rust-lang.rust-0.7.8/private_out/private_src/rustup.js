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
/**
 * @file This module wraps the most commonly used rustup interface, e.g.
 * seeing if rustup is installed or probing for/installing the Rust toolchain
 * components.
 */
const child_process = require("child_process");
const util = require("util");
const vscode_1 = require("vscode");
const spinner_1 = require("./spinner");
const tasks_1 = require("./tasks");
const exec = util.promisify(child_process.exec);
function isInstalledRegex(componentName) {
    return new RegExp(`^(${componentName}.*) \\((default|installed)\\)$`);
}
function rustupUpdate(config) {
    return __awaiter(this, void 0, void 0, function* () {
        spinner_1.startSpinner('Updating…');
        try {
            const { stdout } = yield exec(`${config.path} update`);
            // This test is imperfect because if the user has multiple toolchains installed, they
            // might have one updated and one unchanged. But I don't want to go too far down the
            // rabbit hole of parsing rustup's output.
            if (stdout.includes('unchanged')) {
                spinner_1.stopSpinner('Up to date.');
            }
            else {
                spinner_1.stopSpinner('Up to date. Restart extension for changes to take effect.');
            }
        }
        catch (e) {
            console.log(e);
            spinner_1.stopSpinner('An error occurred whilst trying to update.');
        }
    });
}
exports.rustupUpdate = rustupUpdate;
/**
 * Check for the user-specified toolchain (and that rustup exists).
 */
function ensureToolchain(config) {
    return __awaiter(this, void 0, void 0, function* () {
        if (yield hasToolchain(config)) {
            return;
        }
        const clicked = yield vscode_1.window.showInformationMessage(`${config.channel} toolchain not installed. Install?`, 'Yes');
        if (clicked) {
            yield tryToInstallToolchain(config);
        }
        else {
            throw new Error();
        }
    });
}
exports.ensureToolchain = ensureToolchain;
/**
 * Checks for the required toolchain components and prompts the user to install
 * them if they're missing.
 */
function ensureComponents(config, components) {
    return __awaiter(this, void 0, void 0, function* () {
        if (yield hasComponents(config, components)) {
            return;
        }
        const clicked = yield Promise.resolve(vscode_1.window.showInformationMessage('Some Rust components not installed. Install?', 'Yes'));
        if (clicked) {
            yield installComponents(config, components);
            vscode_1.window.showInformationMessage('Rust components successfully installed!');
        }
        else {
            throw new Error();
        }
    });
}
exports.ensureComponents = ensureComponents;
function hasToolchain({ channel, path }) {
    return __awaiter(this, void 0, void 0, function* () {
        // In addition to a regular channel name, also handle shorthands e.g.
        // `stable-msvc` or `stable-x86_64-msvc` but not `stable-x86_64-pc-msvc`.
        const abiSuffix = ['-gnu', '-msvc'].find(abi => channel.endsWith(abi));
        const [prefix, suffix] = abiSuffix && channel.split('-').length <= 3
            ? [channel.substr(0, channel.length - abiSuffix.length), abiSuffix]
            : [channel, undefined];
        // Skip middle target triple components such as vendor as necessary, since
        // `rustup` output lists toolchains with a full target triple inside
        const matcher = new RegExp([prefix, suffix && `.*${suffix}`].join(''));
        try {
            const { stdout } = yield exec(`${path} toolchain list`);
            return matcher.test(stdout);
        }
        catch (e) {
            console.log(e);
            vscode_1.window.showErrorMessage('Rustup not available. Install from https://www.rustup.rs/');
            throw e;
        }
    });
}
function tryToInstallToolchain(config) {
    return __awaiter(this, void 0, void 0, function* () {
        spinner_1.startSpinner('Installing toolchain…');
        try {
            const command = config.path;
            const args = ['toolchain', 'install', config.channel];
            yield tasks_1.runTaskCommand({ command, args }, 'Installing toolchain…');
            if (!(yield hasToolchain(config))) {
                throw new Error();
            }
        }
        catch (e) {
            console.log(e);
            vscode_1.window.showErrorMessage(`Could not install ${config.channel} toolchain`);
            spinner_1.stopSpinner(`Could not install toolchain`);
            throw e;
        }
    });
}
/**
 * Returns an array of components for specified `config.channel` toolchain.
 * These are parsed as-is, e.g. `rustc-x86_64-unknown-linux-gnu (default)` is a
 * valid listed component name.
 */
function listComponents(config) {
    return __awaiter(this, void 0, void 0, function* () {
        return exec(`${config.path} component list --toolchain ${config.channel}`).then(({ stdout }) => stdout
            .toString()
            .replace('\r', '')
            .split('\n'));
    });
}
function hasComponents(config, components) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const existingComponents = yield listComponents(config);
            return components
                .map(isInstalledRegex)
                .every(isInstalledRegex => existingComponents.some(c => isInstalledRegex.test(c)));
        }
        catch (e) {
            console.log(e);
            vscode_1.window.showErrorMessage(`Can't detect components: ${e.message}`);
            spinner_1.stopSpinner("Can't detect components");
            throw e;
        }
    });
}
exports.hasComponents = hasComponents;
function installComponents(config, components) {
    return __awaiter(this, void 0, void 0, function* () {
        for (const component of components) {
            try {
                const command = config.path;
                const args = [
                    'component',
                    'add',
                    component,
                    '--toolchain',
                    config.channel,
                ];
                yield tasks_1.runTaskCommand({ command, args }, `Installing \`${component}\``);
                const isInstalled = isInstalledRegex(component);
                const listedComponents = yield listComponents(config);
                if (!listedComponents.some(c => isInstalled.test(c))) {
                    throw new Error();
                }
            }
            catch (e) {
                spinner_1.stopSpinner(`Could not install component \`${component}\``);
                vscode_1.window.showErrorMessage(`Could not install component: \`${component}\`${e.message ? `, message: ${e.message}` : ''}`);
                throw e;
            }
        }
    });
}
exports.installComponents = installComponents;
/**
 * Parses given output of `rustup show` and retrieves the local active toolchain.
 */
function parseActiveToolchain(rustupOutput) {
    // There may a default entry under 'installed toolchains' section, so search
    // for currently active/overridden one only under 'active toolchain' section
    const activeToolchainsIndex = rustupOutput.search('active toolchain');
    if (activeToolchainsIndex !== -1) {
        rustupOutput = rustupOutput.substr(activeToolchainsIndex);
        const matchActiveChannel = /^(\S*) \((?:default|overridden)/gm;
        const match = matchActiveChannel.exec(rustupOutput);
        if (!match) {
            throw new Error(`couldn't find active toolchain under 'active toolchains'`);
        }
        else if (matchActiveChannel.exec(rustupOutput)) {
            throw new Error(`multiple active toolchains found under 'active toolchains'`);
        }
        return match[1];
    }
    // Try matching the third line as the active toolchain
    const match = /^(?:.*\r?\n){2}(\S*) \((?:default|overridden)/.exec(rustupOutput);
    if (match) {
        return match[1];
    }
    throw new Error(`couldn't find active toolchains`);
}
exports.parseActiveToolchain = parseActiveToolchain;
function getVersion(config) {
    return __awaiter(this, void 0, void 0, function* () {
        const versionRegex = /rustup ([0-9]+\.[0-9]+\.[0-9]+)/;
        const output = yield exec(`${config.path} --version`);
        const versionMatch = output.stdout.toString().match(versionRegex);
        if (versionMatch && versionMatch.length >= 2) {
            return versionMatch[1];
        }
        else {
            throw new Error("Couldn't parse rustup version");
        }
    });
}
exports.getVersion = getVersion;
/**
 * Returns whether Rustup is invokable and available.
 */
function hasRustup(config) {
    return getVersion(config)
        .then(() => true)
        .catch(() => false);
}
exports.hasRustup = hasRustup;
/**
 * Returns active (including local overrides) toolchain, as specified by rustup.
 * May throw if rustup at specified path can't be executed.
 */
function getActiveChannel(wsPath, rustupPath) {
    // rustup info might differ depending on where it's executed
    // (e.g. when a toolchain is locally overriden), so executing it
    // under our current workspace root should give us close enough result
    let activeChannel;
    try {
        // `rustup show active-toolchain` is available since rustup 1.12.0
        activeChannel = child_process
            .execSync(`${rustupPath} show active-toolchain`, {
            cwd: wsPath,
        })
            .toString()
            .trim();
        // Since rustup 1.17.0 if the active toolchain is the default, we're told
        // by means of a " (default)" suffix, so strip that off if it's present
        // If on the other hand there's an override active, we'll get an
        // " (overridden by ...)" message instead.
        activeChannel = activeChannel.replace(/ \(.*\)$/, '');
    }
    catch (e) {
        // Possibly an old rustup version, so try rustup show
        const showOutput = child_process
            .execSync(`${rustupPath} show`, {
            cwd: wsPath,
        })
            .toString();
        activeChannel = parseActiveToolchain(showOutput);
    }
    console.info(`Using active channel: ${activeChannel}`);
    return activeChannel;
}
exports.getActiveChannel = getActiveChannel;
//# sourceMappingURL=rustup.js.map