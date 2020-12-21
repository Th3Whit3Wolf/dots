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
const assert = require("assert");
const fs = require("fs");
const node_fetch_1 = require("node-fetch");
const stream = require("stream");
const util = require("util");
const vscode = require("vscode");
const pipeline = util.promisify(stream.pipeline);
const GITHUB_API_ENDPOINT_URL = 'https://api.github.com';
function fetchRelease(owner, repository, releaseTag) {
    return __awaiter(this, void 0, void 0, function* () {
        const apiEndpointPath = `/repos/${owner}/${repository}/releases/tags/${releaseTag}`;
        const requestUrl = GITHUB_API_ENDPOINT_URL + apiEndpointPath;
        console.debug('Issuing request for released artifacts metadata to', requestUrl);
        const response = yield node_fetch_1.default(requestUrl, {
            headers: { Accept: 'application/vnd.github.v3+json' },
        });
        if (!response.ok) {
            console.error('Error fetching artifact release info', {
                requestUrl,
                releaseTag,
                response: {
                    headers: response.headers,
                    status: response.status,
                    body: yield response.text(),
                },
            });
            throw new Error(`Got response ${response.status} when trying to fetch ` +
                `release info for ${releaseTag} release`);
        }
        // We skip runtime type checks for simplicity (here we cast from `any` to `GithubRelease`)
        const release = yield response.json();
        return release;
    });
}
exports.fetchRelease = fetchRelease;
function download(downloadUrl, destinationPath, progressTitle, { mode } = {}) {
    return __awaiter(this, void 0, void 0, function* () {
        yield vscode.window.withProgress({
            location: vscode.ProgressLocation.Notification,
            cancellable: false,
            title: progressTitle,
        }, (progress, _cancellationToken) => __awaiter(this, void 0, void 0, function* () {
            let lastPercentage = 0;
            yield downloadFile(downloadUrl, destinationPath, mode, (readBytes, totalBytes) => {
                const newPercentage = (readBytes / totalBytes) * 100;
                progress.report({
                    message: newPercentage.toFixed(0) + '%',
                    increment: newPercentage - lastPercentage,
                });
                lastPercentage = newPercentage;
            });
        }));
    });
}
exports.download = download;
/**
 * Downloads file from `url` and stores it at `destFilePath` with `destFilePermissions`.
 * `onProgress` callback is called on recieveing each chunk of bytes
 * to track the progress of downloading, it gets the already read and total
 * amount of bytes to read as its parameters.
 */
function downloadFile(url, destFilePath, mode, onProgress) {
    return __awaiter(this, void 0, void 0, function* () {
        const res = yield node_fetch_1.default(url);
        if (!res.ok) {
            console.error('Error', res.status, 'while downloading file from', url);
            console.error({ body: yield res.text(), headers: res.headers });
            throw new Error(`Got response ${res.status} when trying to download a file.`);
        }
        const totalBytes = Number(res.headers.get('content-length'));
        assert(!Number.isNaN(totalBytes), 'Sanity check of content-length protocol');
        console.debug('Downloading file of', totalBytes, 'bytes size from', url, 'to', destFilePath);
        let readBytes = 0;
        res.body.on('data', (chunk) => {
            readBytes += chunk.length;
            onProgress(readBytes, totalBytes);
        });
        const destFileStream = fs.createWriteStream(destFilePath, { mode });
        yield pipeline(res.body, destFileStream);
        return new Promise(resolve => {
            destFileStream.on('close', resolve);
            destFileStream.destroy();
            // Details on workaround: https://github.com/rust-analyzer/rust-analyzer/pull/3092#discussion_r378191131
            // Issue at nodejs repo: https://github.com/nodejs/node/issues/31776
        });
    });
}
//# sourceMappingURL=net.js.map