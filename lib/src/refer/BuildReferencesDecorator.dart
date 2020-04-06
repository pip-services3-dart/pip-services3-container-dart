// /** @module refer */
// /** @hidden */
// let _ = require('lodash');

// import { IReferences } from 'pip-services3-commons-node';
// import { ReferenceException } from 'pip-services3-commons-node';
// import { Descriptor } from 'pip-services3-commons-node';
// import { IFactory } from 'pip-services3-components-node';

// import { ReferencesDecorator } from './ReferencesDecorator';

// /**
//  * References decorator that automatically creates missing components using
//  * available component factories upon component retrival.
//  */
// export class BuildReferencesDecorator extends ReferencesDecorator {
//     /**
// 	 * Creates a new instance of the decorator.
// 	 * 
// 	 * @param nextReferences 		the next references or decorator in the chain.
// 	 * @param topReferences 		the decorator at the top of the chain.
// 	 */
//     public constructor(nextReferences: IReferences, topReferences: IReferences) {
//     	super(nextReferences, topReferences);
//     }
    
//     /**
//      * Finds a factory capable creating component by given descriptor
//      * from the components registered in the references.
//      * 
//      * @param locator   a locator of component to be created.
//      * @returns found factory or null if factory was not found.
//      */
//     public findFactory(locator: any): IFactory {
//         let components = this.getAll();
//         for (let index = 0; index < components.length; index++) {
//             let component = components[index];
//             if (_.isFunction(component.canCreate) && _.isFunction(component.create)) {
//                 if (component.canCreate(locator))
//                     return component;
//             }
//         }

//         return null;
//     }

//     /**
// 	 * Creates a component identified by given locator.
// 	 * 
// 	 * @param locator 	a locator to identify component to be created.
//      * @param factory   a factory that shall create the component.
// 	 * @returns the created component.
// 	 * 
// 	 * @throws a CreateException if the factory is not able to create the component.
//      * 
//      * @see [[findFactory]]
//      */
//     public create(locator: any, factory: IFactory): any {
//         if (factory == null) return null;

//         try {
//             // Create component
//             return factory.create(locator);
//         } catch (ex) {
//             return null;
//         }
//     }

//     /**
//      * Clarifies a component locator by merging two descriptors into one to replace missing fields.
//      * That allows to get a more complete descriptor that includes all possible fields.
//      * 
//      * @param locator   a component locator to clarify.
//      * @param factory   a factory that shall create the component.
//      * @returns clarified component descriptor (locator)
//      */
//     public clarifyLocator(locator: any, factory: IFactory): any {
//         if (factory == null) return locator;
//         if (!(locator instanceof Descriptor)) return locator;
        
//         let anotherLocator = factory.canCreate(locator);
//     	if (anotherLocator == null) return locator;
//     	if (!(anotherLocator instanceof Descriptor)) return locator;
    	
//     	let descriptor: Descriptor = locator;
//     	let anotherDescriptor: Descriptor = anotherLocator;
    	
//     	return new Descriptor(
//     		descriptor.getGroup() != null ? descriptor.getGroup() : anotherDescriptor.getGroup(),
//     		descriptor.getType() != null ? descriptor.getType() : anotherDescriptor.getType(),
//     		descriptor.getKind() != null ? descriptor.getKind() : anotherDescriptor.getKind(),
//     		descriptor.getName() != null ? descriptor.getName() : anotherDescriptor.getName(),
//     		descriptor.getVersion() != null ? descriptor.getVersion() : anotherDescriptor.getVersion()
// 		);
//     }

//     /**
// 	 * Gets all component references that match specified locator.
// 	 * 
// 	 * @param locator 	the locator to find a reference by.
// 	 * @param required 	forces to raise an exception if no reference is found.
// 	 * @returns a list with matching component references.
// 	 * 
// 	 * @throws a [[ReferenceException]] when required is set to true but no references found.
//      */
//     public find<T>(locator: any, required: boolean): T[] {
//         let components = super.find<T>(locator, false);

//         // Try to create the component
//         if (required && components.length == 0) {
//             let factory = this.findFactory(locator);
//             let component = this.create(locator, factory);
//             if (component != null) {
//                 try {
//                 	locator = this.clarifyLocator(locator, factory);
//                     this.topReferences.put(locator, component);
//                     components.push(component);
//                 } catch (ex) {
//                     // Ignore exception
//                 }
//             }
//         }

//         // Throw exception is no required components found
//         if (required && components.length == 0)
//             throw new ReferenceException(null, locator);

//         return components;
//     }
// }
