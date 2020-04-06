// /** @module config */
// import { Descriptor } from 'pip-services3-commons-node';
// import { TypeDescriptor } from 'pip-services3-commons-node';
// import { ConfigParams } from 'pip-services3-commons-node';
// import { ConfigException } from 'pip-services3-commons-node';

// /**
//  * Configuration of a component inside a container.
//  * 
//  * The configuration includes type information or descriptor,
//  * and component configuration parameters.
//  */
// export class ComponentConfig {

//     /**
//      * Creates a new instance of the component configuration.
//      * 
//      * @param descriptor    (optional) a components descriptor (locator).
//      * @param type          (optional) a components type descriptor.
//      * @param config        (optional) component configuration parameters.
//      */
//     public constructor(descriptor?: Descriptor, type?: TypeDescriptor, config?: ConfigParams) {
//         this.descriptor = descriptor;
//         this.type = type;
//         this.config = config;
//     }

// 	public descriptor: Descriptor = null;
// 	public type: TypeDescriptor = null;
// 	public config: ConfigParams = null;

//     /**
//      * Creates a new instance of ComponentConfig based on
//      * section from container configuration.
//      * 
//      * @param config    component parameters from container configuration
//      * @returns a newly created ComponentConfig
//      * 
//      * @throws ConfigException when neither component descriptor or type is found.
//      */
//     public static fromConfig(config: ConfigParams): ComponentConfig {
//         var descriptor = Descriptor.fromString(config.getAsNullableString("descriptor"));
//         var type = TypeDescriptor.fromString(config.getAsNullableString("type"));

//         if (descriptor == null && type == null)
//             throw new ConfigException(null, "BAD_CONFIG", "Component configuration must have descriptor or type");

//         return new ComponentConfig(descriptor, type, config);
//     }
		
// }