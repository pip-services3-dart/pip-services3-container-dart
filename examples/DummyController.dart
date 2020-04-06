// import { IReferenceable } from 'pip-services3-commons-node';
// import { IReferences } from 'pip-services3-commons-node';
// import { IReconfigurable } from 'pip-services3-commons-node';
// import { IOpenable } from 'pip-services3-commons-node';
// import { INotifiable } from 'pip-services3-commons-node';
// import { FixedRateTimer } from 'pip-services3-commons-node';
// import { Parameters } from 'pip-services3-commons-node';
// import { ConfigParams } from 'pip-services3-commons-node';
// import { CompositeLogger } from 'pip-services3-components-node';

// import { ContainerConfig } from '../src/config/ContainerConfig';

// export class DummyController implements IReferenceable, IReconfigurable, IOpenable, INotifiable {
//     private readonly _timer = new FixedRateTimer(this, 1000, 1000);
//     private readonly _logger: CompositeLogger = new CompositeLogger();
//     private _message: string = "Hello World!";
//     private _counter: number = 0;

//     public constructor() {}

// 	public get message(): string { 
//         return this._message; 
//     }
// 	public set message(value: string) { 
//         this._message = value; 
//     }

// 	public get counter(): number { 
//         return this._counter; 
//     }
// 	public set counter(value: number) { 
//         this._counter = value; 
//     }

//     public configure(config: ConfigParams): void {
//         this.message = config.getAsStringWithDefault("message", this.message);
//     }

//     public setReferences(references: IReferences): void {
//         this._logger.setReferences(references);
//     }

//     public isOpen(): boolean {
//         return this._timer.isStarted();
//     }

//     public open(correlationId: string, callback?: (err: any) => void): void {
//         try {
//             this._timer.start();
//             this._logger.trace(correlationId, "Dummy controller opened");
//             if (callback) callback(null);
//         } catch (ex) {
//             this._logger.error(correlationId, ex, "Failed to open Dummy container");
//             if (callback) callback(ex);
//             else throw ex;
//         }
//     }
		
//     public close(correlationId: string, callback?: (err: any) => void): void {
//         try {
//             this._timer.stop();
//             this._logger.trace(correlationId, "Dummy controller closed");
//             if (callback) callback(null);
//         } catch (ex) {
//             this._logger.error(correlationId, ex, "Failed to close Dummy container");
//             if (callback) callback(ex);
//             else throw ex;
//         }
//     }

//     public notify(correlationId: string, args: Parameters): void {
//         this._logger.info(correlationId, "%d - %s", this.counter++, this.message);
//     }

// }
