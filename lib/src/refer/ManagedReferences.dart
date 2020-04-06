// /** @module refer */
// import { IOpenable } from 'pip-services3-commons-node';
// import { References } from 'pip-services3-commons-node';

// import { ReferencesDecorator } from './ReferencesDecorator';
// import { BuildReferencesDecorator } from './BuildReferencesDecorator';
// import { LinkReferencesDecorator } from './LinkReferencesDecorator';
// import { RunReferencesDecorator } from './RunReferencesDecorator';

// /**
//  * Managed references that in addition to keeping and locating references can also 
//  * manage their lifecycle:
//  * - Auto-creation of missing component using available factories
//  * - Auto-linking newly added components
//  * - Auto-opening newly added components
//  * - Auto-closing removed components
//  * 
//  * @see [[RunReferencesDecorator]]
//  * @see [[LinkReferencesDecorator]]
//  * @see [[BuildReferencesDecorator]]
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/classes/refer.references.html References]] (in the PipServices "Commons" package)
//  */
// export class ManagedReferences extends ReferencesDecorator implements IOpenable {
//     protected _references: References;
//     protected _builder: BuildReferencesDecorator;
//     protected _linker: LinkReferencesDecorator;
//     protected _runner: RunReferencesDecorator;

//     /**
//      * Creates a new instance of the references
//      * 
//      * @param tuples    tuples where odd values are component locators (descriptors) and even values are component references
//      */
//     public constructor(tuples: any[] = null) {
//         super(null, null);

//         this._references = new References(tuples);
//         this._builder = new BuildReferencesDecorator(this._references, this);
//         this._linker = new LinkReferencesDecorator(this._builder, this);
//         this._runner = new RunReferencesDecorator(this._linker, this);

//         this.nextReferences = this._runner;
//     }

//     /** 
// 	 * Checks if the component is opened.
// 	 * 
// 	 * @returns true if the component has been opened and false otherwise.
//      */
//     public isOpen(): boolean {
//         return this._linker.isOpen() && this._runner.isOpen();
//     }
    
//     /**
// 	 * Opens the component.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
//      * @param callback 			callback function that receives error or null no errors occured.
//      */
//     public open(correlationId: string, callback?: (err: any) => void): void {
//         this._linker.open(correlationId, (err) => {
//             if (err == null)
//                 this._runner.open(correlationId, callback);
//             else if (callback) callback(err);
//         });
//     }


//     /**
// 	 * Closes component and frees used resources.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
//      * @param callback 			callback function that receives error or null no errors occured.
//      */
//     public close(correlationId: string, callback?: (err: any) => void): void {
//         this._runner.close(correlationId, (err) => {
//             if (err == null)
//                 this._linker.close(correlationId, callback);
//             else if (callback) callback(err);
//         });
//     }

//     /**
// 	 * Creates a new ManagedReferences object filled with provided key-value pairs called tuples.
// 	 * Tuples parameters contain a sequence of locator1, component1, locator2, component2, ... pairs.
// 	 * 
// 	 * @param tuples	the tuples to fill a new ManagedReferences object.
// 	 * @returns			a new ManagedReferences object.
//      */
// 	public static fromTuples(...tuples: any[]): ManagedReferences {
// 		return new ManagedReferences(tuples);
// 	}
// }
