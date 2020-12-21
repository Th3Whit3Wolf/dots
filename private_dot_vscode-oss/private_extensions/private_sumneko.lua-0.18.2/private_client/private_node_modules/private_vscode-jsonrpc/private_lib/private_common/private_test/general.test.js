/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */
'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const assert = require("assert");
const api_1 = require("../api");
suite('General Tests', () => {
    test('Trace#fromString', () => {
        assert(api_1.Trace.Off === api_1.Trace.fromString(10));
    });
});
//# sourceMappingURL=general.test.js.map