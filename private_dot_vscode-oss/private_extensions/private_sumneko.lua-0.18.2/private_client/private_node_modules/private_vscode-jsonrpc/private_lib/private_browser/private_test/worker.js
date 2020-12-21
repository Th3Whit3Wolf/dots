"use strict";
/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */
Object.defineProperty(exports, "__esModule", { value: true });
const main_1 = require("../main");
const reader = new main_1.BrowserMessageReader(self);
const writer = new main_1.BrowserMessageWriter(self);
reader.listen((_message) => {
    const response = {
        jsonrpc: '2.0',
        id: 1,
        result: 42
    };
    writer.write(response);
});
//# sourceMappingURL=worker.js.map