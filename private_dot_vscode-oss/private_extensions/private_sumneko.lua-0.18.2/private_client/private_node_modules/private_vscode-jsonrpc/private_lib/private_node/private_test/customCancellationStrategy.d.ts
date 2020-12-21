import { CancellationReceiverStrategy, CancellationSenderStrategy } from '../main';
export declare function getCustomCancellationStrategy(): {
    receiver: CancellationReceiverStrategy;
    sender: CancellationSenderStrategy;
    dispose: () => void;
};
