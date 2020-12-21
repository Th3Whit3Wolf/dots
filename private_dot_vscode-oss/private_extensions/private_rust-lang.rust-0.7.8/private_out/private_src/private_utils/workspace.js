"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs = require("fs");
const path = require("path");
const vscode_1 = require("vscode");
// searches up the folder structure until it finds a Cargo.toml
function nearestParentWorkspace(curWorkspace, filePath) {
    // check that the workspace folder already contains the "Cargo.toml"
    const workspaceRoot = curWorkspace.uri.fsPath;
    const rootManifest = path.join(workspaceRoot, 'Cargo.toml');
    if (fs.existsSync(rootManifest)) {
        return curWorkspace;
    }
    // algorithm that will strip one folder at a time and check if that folder contains "Cargo.toml"
    let current = filePath;
    while (true) {
        const old = current;
        current = path.dirname(current);
        // break in case there is a bug that could result in a busy loop
        if (old === current) {
            break;
        }
        // break in case the strip folder reached the workspace root
        if (workspaceRoot === current) {
            break;
        }
        // check if "Cargo.toml" is present in the parent folder
        const cargoPath = path.join(current, 'Cargo.toml');
        if (fs.existsSync(cargoPath)) {
            // ghetto change the uri on Workspace folder to make vscode think it's located elsewhere
            return Object.assign(Object.assign({}, curWorkspace), { name: path.basename(current), uri: vscode_1.Uri.file(current) });
        }
    }
    return curWorkspace;
}
exports.nearestParentWorkspace = nearestParentWorkspace;
function getOuterMostWorkspaceFolder(folder) {
    const sortedFoldersByPrefix = (vscode_1.workspace.workspaceFolders || [])
        .map(folder => normalizeUriToPathPrefix(folder.uri))
        .sort((a, b) => a.length - b.length);
    const uri = normalizeUriToPathPrefix(folder.uri);
    const outermostPath = sortedFoldersByPrefix.find(pre => uri.startsWith(pre));
    return outermostPath
        ? vscode_1.workspace.getWorkspaceFolder(vscode_1.Uri.parse(outermostPath)) || folder
        : folder;
}
exports.getOuterMostWorkspaceFolder = getOuterMostWorkspaceFolder;
/**
 * Transforms a given URI to a path prefix, namely ensures that each path
 * segment ends with a path separator `/`.
 */
function normalizeUriToPathPrefix(uri) {
    let result = uri.toString();
    if (result.charAt(result.length - 1) !== '/') {
        result = result + '/';
    }
    return result;
}
//# sourceMappingURL=workspace.js.map