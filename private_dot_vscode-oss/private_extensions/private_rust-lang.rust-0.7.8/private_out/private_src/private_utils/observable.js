"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * A wrapper around a value of type `T` that can be subscribed to whenever the
 * underlying value changes.
 */
class Observable {
    constructor(value) {
        this._listeners = new Set();
        this._value = value;
    }
    /** Returns the current value. */
    get value() {
        return this._value;
    }
    /** Every change to the value triggers all the registered callbacks. */
    set value(value) {
        this._value = value;
        this._listeners.forEach(fn => fn(value));
    }
    /**
     * Registers a listener function that's called whenever the underlying value
     * changes.
     * @returns a function that unregisters the listener when called.
     */
    observe(fn) {
        this._listeners.add(fn);
        return { dispose: () => this._listeners.delete(fn) };
    }
}
exports.Observable = Observable;
//# sourceMappingURL=observable.js.map