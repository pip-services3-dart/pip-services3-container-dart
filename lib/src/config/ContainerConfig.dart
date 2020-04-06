// /** @module config */
// import { ConfigParams } from 'pip-services3-commons-node';

// import { ComponentConfig } from './ComponentConfig';

// /**
//  * Container configuration defined as a list of component configurations.
//  * 
//  * @see [[ComponentConfig]]
//  */
// export class ContainerConfig extends Array<ComponentConfig> {

//     /**
//      * Creates a new instance of container configuration.
//      * 
//      * @param components    (optional) a list of component configurations.
//      */
//     public constructor(components?: ComponentConfig[]) {
//         super();

//         if (components != null)
//             super.push(...components);
//     }

//     /**
// 	 * Creates a new ContainerConfig object filled with key-value pairs from specified object.
//      * The value is converted into ConfigParams object which is used to create the object.
// 	 * 
// 	 * @param value		an object with key-value pairs used to initialize a new ContainerConfig.
// 	 * @returns			a new ContainerConfig object.
//      * 
//      * @see [[fromConfig]]
//      */
//     public static fromValue(value: any): ContainerConfig {
//         let config = ConfigParams.fromValue(value);
//         return ContainerConfig.fromConfig(config);
//     }

//     /**
// 	 * Creates a new ContainerConfig object based on configuration parameters.
//      * Each section in the configuration parameters is converted into a component configuration.
// 	 * 
// 	 * @param value		an object with key-value pairs used to initialize a new ContainerConfig.
// 	 * @returns			a new ContainerConfig object.
//      */
//     public static fromConfig(config: ConfigParams): ContainerConfig {
//         let result = new ContainerConfig();
//         if (config == null) return result;

//         let names = config.getSectionNames();
//         for (var i = 0; i < names.length; i++) {
//             let componentConfig = config.getSection(names[i]);
//             result.push(ComponentConfig.fromConfig(componentConfig));
//         }

//         return result;
//     }
		
// }