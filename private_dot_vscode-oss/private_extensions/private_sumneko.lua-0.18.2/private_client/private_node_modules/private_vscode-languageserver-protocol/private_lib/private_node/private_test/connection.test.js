/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */
'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const assert = require("assert");
const stream_1 = require("stream");
const main_1 = require("../main");
const protocol_1 = require("../../common/protocol");
const vscode_jsonrpc_1 = require("vscode-jsonrpc");
const vscode_languageserver_types_1 = require("vscode-languageserver-types");
class NullLogger {
    error(_message) {
    }
    warn(_message) {
    }
    info(_message) {
    }
    log(_message) {
    }
}
class TestStream extends stream_1.Duplex {
    _write(chunk, _encoding, done) {
        this.emit('data', chunk);
        done();
    }
    _read(_size) {
    }
}
suite('Connection Tests', () => {
    test('Ensure proper param passing', async () => {
        const up = new TestStream();
        const down = new TestStream();
        const logger = new NullLogger();
        const serverConnection = main_1.createProtocolConnection(new main_1.StreamMessageReader(up), new main_1.StreamMessageWriter(down), logger);
        const clientConnection = main_1.createProtocolConnection(new main_1.StreamMessageReader(down), new main_1.StreamMessageWriter(up), logger);
        serverConnection.listen();
        clientConnection.listen();
        let paramsCorrect = false;
        serverConnection.onRequest(main_1.InitializeRequest.type, (params) => {
            paramsCorrect = !Array.isArray(params);
            let result = {
                capabilities: {}
            };
            return result;
        });
        const init = {
            rootUri: 'file:///home/dirkb',
            processId: 1,
            capabilities: {},
            workspaceFolders: null,
        };
        await clientConnection.sendRequest(main_1.InitializeRequest.type, init);
        assert.ok(paramsCorrect, 'Parameters are transferred correctly');
    });
});
suite('Partial result tests', () => {
    let serverConnection;
    let clientConnection;
    let progressType = new vscode_jsonrpc_1.ProgressType();
    setup(() => {
        const up = new TestStream();
        const down = new TestStream();
        const logger = new NullLogger();
        serverConnection = main_1.createProtocolConnection(new main_1.StreamMessageReader(up), new main_1.StreamMessageWriter(down), logger);
        clientConnection = main_1.createProtocolConnection(new main_1.StreamMessageReader(down), new main_1.StreamMessageWriter(up), logger);
        serverConnection.listen();
        clientConnection.listen();
    });
    test('Token provided', async () => {
        serverConnection.onRequest(protocol_1.DocumentSymbolRequest.type, (params) => {
            assert.ok(params.partialResultToken === '3b1db4c9-e011-489e-a9d1-0653e64707c2');
            return [];
        });
        const params = {
            textDocument: { uri: 'file:///abc.txt' },
            partialResultToken: '3b1db4c9-e011-489e-a9d1-0653e64707c2'
        };
        await clientConnection.sendRequest(protocol_1.DocumentSymbolRequest.type, params);
    });
    test('Result reported', async () => {
        let result = {
            name: 'abc',
            kind: vscode_languageserver_types_1.SymbolKind.Class,
            location: {
                uri: 'file:///abc.txt',
                range: { start: { line: 0, character: 1 }, end: { line: 2, character: 3 } }
            }
        };
        serverConnection.onRequest(protocol_1.DocumentSymbolRequest.type, (params) => {
            assert.ok(params.partialResultToken === '3b1db4c9-e011-489e-a9d1-0653e64707c2');
            serverConnection.sendProgress(progressType, params.partialResultToken, [result]);
            return [];
        });
        const params = {
            textDocument: { uri: 'file:///abc.txt' },
            partialResultToken: '3b1db4c9-e011-489e-a9d1-0653e64707c2'
        };
        let progressOK = false;
        clientConnection.onProgress(progressType, '3b1db4c9-e011-489e-a9d1-0653e64707c2', (values) => {
            progressOK = (values !== undefined && values.length === 1);
        });
        await clientConnection.sendRequest(protocol_1.DocumentSymbolRequest.type, params);
        assert.ok(progressOK);
    });
});
suite('Work done tests', () => {
    let serverConnection;
    let clientConnection;
    const progressType = new vscode_jsonrpc_1.ProgressType();
    setup(() => {
        const up = new TestStream();
        const down = new TestStream();
        const logger = new NullLogger();
        serverConnection = main_1.createProtocolConnection(new main_1.StreamMessageReader(up), new main_1.StreamMessageWriter(down), logger);
        clientConnection = main_1.createProtocolConnection(new main_1.StreamMessageReader(down), new main_1.StreamMessageWriter(up), logger);
        serverConnection.listen();
        clientConnection.listen();
    });
    test('Token provided', async () => {
        serverConnection.onRequest(protocol_1.DocumentSymbolRequest.type, (params) => {
            assert.ok(params.workDoneToken === '3b1db4c9-e011-489e-a9d1-0653e64707c2');
            return [];
        });
        const params = {
            textDocument: { uri: 'file:///abc.txt' },
            workDoneToken: '3b1db4c9-e011-489e-a9d1-0653e64707c2'
        };
        await clientConnection.sendRequest(protocol_1.DocumentSymbolRequest.type, params);
    });
    test('Result reported', async () => {
        serverConnection.onRequest(protocol_1.DocumentSymbolRequest.type, (params) => {
            assert.ok(params.workDoneToken === '3b1db4c9-e011-489e-a9d1-0653e64707c2');
            serverConnection.sendProgress(progressType, params.workDoneToken, {
                kind: 'begin',
                title: 'progress'
            });
            serverConnection.sendProgress(progressType, params.workDoneToken, {
                kind: 'report',
                message: 'message'
            });
            serverConnection.sendProgress(progressType, params.workDoneToken, {
                kind: 'end',
                message: 'message'
            });
            return [];
        });
        const params = {
            textDocument: { uri: 'file:///abc.txt' },
            workDoneToken: '3b1db4c9-e011-489e-a9d1-0653e64707c2'
        };
        let result = '';
        clientConnection.onProgress(progressType, '3b1db4c9-e011-489e-a9d1-0653e64707c2', (value) => {
            result += value.kind;
        });
        await clientConnection.sendRequest(protocol_1.DocumentSymbolRequest.type, params);
        assert.ok(result === 'beginreportend');
    });
});
//# sourceMappingURL=connection.test.js.map