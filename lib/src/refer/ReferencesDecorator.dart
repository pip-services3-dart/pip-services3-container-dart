// /** @module refer */
// import { IReferences } from 'pip-services3-commons-node';

// /**
//  * Chainable decorator for IReferences that allows to inject additional capabilities
//  * such as automatic component creation, automatic registration and opening.
//  * 
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/refer.ireferences.html IReferences]] (in the PipServices "Commons" package)
//  */
// export class ReferencesDecorator implements IReferences {
	
// 	/**
// 	 * Creates a new instance of the decorator.
// 	 * 
// 	 * @param nextReferences 		the next references or decorator in the chain.
// 	 * @param topReferences 		the decorator at the top of the chain.
// 	 */
// 	public constructor(nextReferences: IReferences, topReferences: IReferences) {
//         this.nextReferences = nextReferences != null ? nextReferences : topReferences;
//         this.topReferences = topReferences != null ? topReferences : nextReferences;
//     }

// 	/**
// 	 * The next references or decorator in the chain.
// 	 */
// 	public nextReferences: IReferences;

// 	/**
// 	 * The decorator at the top of the chain.
// 	 */
// 	public topReferences: IReferences;

// 	/**
// 	 * Puts a new reference into this reference map.
// 	 * 
// 	 * @param locator 	a locator to find the reference by.
// 	 * @param component a component reference to be added.
// 	 */
// 	public put(locator: any, component: any): any {
// 		return this.nextReferences.put(locator, component);
// 	}
	
// 	/**
// 	 * Removes a previously added reference that matches specified locator.
// 	 * If many references match the locator, it removes only the first one.
// 	 * When all references shall be removed, use [[removeAll]] method instead.
// 	 * 
// 	 * @param locator 	a locator to remove reference
// 	 * @returns the removed component reference.
// 	 * 
// 	 * @see [[removeAll]]
// 	 */
// 	public remove(locator: any): any {
// 		return this.nextReferences.remove(locator);
// 	}

// 	/**
// 	 * Removes all component references that match the specified locator. 
// 	 * 
// 	 * @param locator 	the locator to remove references by.
// 	 * @returns a list, containing all removed references.
// 	 */
// 	public removeAll(locator: any): any[] {
// 		return this.nextReferences.removeAll(locator);
// 	}

// 	/**
// 	 * Gets locators for all registered component references in this reference map.
// 	 * 
// 	 * @returns a list with component locators.
// 	 */
//     public getAllLocators(): any[] {
// 		return this.nextReferences.getAllLocators();
// 	}

// 	/**
// 	 * Gets all component references registered in this reference map.
// 	 * 	
// 	 * @returns a list with component references.
// 	 */
// 	public getAll(): any[] {
// 		return this.nextReferences.getAll();
// 	}
		
// 	/**
// 	 * Gets an optional component reference that matches specified locator.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a matching component reference or null if nothing was found.
// 	 */
//     public getOneOptional<T>(locator: any): T {
//     	try {
// 	        let components = this.find<T>(locator, false);
//             return components.length > 0 ? components[0] : null;
//     	} catch (ex) {
//     		return null;
//     	}
//     }

// 	/**
// 	 * Gets a required component reference that matches specified locator.
// 	 * 
// 	 * @param locator 	the locator to find a reference by.	 
// 	 * @returns a matching component reference.
// 	 * @throws a [[ReferenceException]] when no references found.
// 	 */
//     public getOneRequired<T>(locator: any): T {
//         let components = this.find<T>(locator, true);
//         return components.length > 0 ? components[0] : null;
//     }

// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a list with matching component references or empty list if nothing was found.
// 	 */
//     public getOptional<T>(locator: any): T[] {
//     	try {
//     		return this.find<T>(locator, false);
//     	} catch (ex) {
//             return [];
//     	}
//     }

// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * At least one component reference must be present.
// 	 * If it doesn't the method throws an error.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a list with matching component references.
// 	 * 
// 	 * @throws a [[ReferenceException]] when no references found.
// 	 */
//     public getRequired<T>(locator: any): T[] {
//         return this.find<T>(locator, true);
//     }

// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * 
// 	 * @param locator 	the locator to find a reference by.
// 	 * @param required 	forces to raise an exception if no reference is found.
// 	 * @returns a list with matching component references.
// 	 * 
// 	 * @throws a [[ReferenceException]] when required is set to true but no references found.
// 	 */
// 	public find<T>(locator: any, required: boolean): T[] {
// 		return this.nextReferences.find<T>(locator, required);
//     }

// }
