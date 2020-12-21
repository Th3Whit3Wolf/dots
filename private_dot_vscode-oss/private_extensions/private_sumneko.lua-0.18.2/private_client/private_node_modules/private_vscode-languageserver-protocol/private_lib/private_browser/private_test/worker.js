"use strict";
/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */
Object.defineProperty(exports, "__esModule", { value: true });
const main_1 = require("../main");
const api_1 = require("../../common/api");
const reader = new main_1.BrowserMessageReader(self);
const writer = new main_1.BrowserMessageWriter(self);
const connection = main_1.createProtocolConnection(reader, writer);
connection.onRequest(api_1.CompletionRequest.type, (_params) => {
    return [];
});
connection.listen();
//# sourceMappingURL=worker.js.map