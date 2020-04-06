// /** @module config */
// import { JsonConfigReader } from 'pip-services3-components-node';
// import { YamlConfigReader } from 'pip-services3-components-node';
// import { ConfigException } from 'pip-services3-commons-node';
// import { ConfigParams } from 'pip-services3-commons-node';

// import { ContainerConfig } from './ContainerConfig';

// /**
//  * Helper class that reads container configuration from JSON or YAML file.
//  */
// export class ContainerConfigReader {

//     /**
//      * Reads container configuration from JSON or YAML file.
//      * The type of the file is determined by file extension.
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param path              a path to component configuration file.
//      * @param parameters        values to parameters the configuration or null to skip parameterization.
//      * @returns the read container configuration
//      */
//     public static readFromFile(correlationId: string, path: string, parameters: ConfigParams): ContainerConfig {
//         if (path == null)
//             throw new ConfigException(correlationId, "NO_PATH", "Missing config file path");

//         let ext = path.split('.').pop();

//         if (ext == "json")
//             return ContainerConfigReader.readFromJsonFile(correlationId, path, parameters);

//         if (ext == "yaml" || ext == "yml")
//             return ContainerConfigReader.readFromYamlFile(correlationId, path, parameters);

//         // By default read as JSON
//         return ContainerConfigReader.readFromJsonFile(correlationId, path, parameters);
//     }

//     /**
//      * Reads container configuration from JSON file.
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param path              a path to component configuration file.
//      * @param parameters        values to parameters the configuration or null to skip parameterization.
//      * @returns the read container configuration
//      */
//     public static readFromJsonFile(correlationId: string, path: string, parameters: ConfigParams): ContainerConfig {
//         let config = JsonConfigReader.readConfig(correlationId, path, parameters);
//         return ContainerConfig.fromConfig(config);
//     }

//     /**
//      * Reads container configuration from YAML file.
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param path              a path to component configuration file.
//      * @param parameters        values to parameters the configuration or null to skip parameterization.
//      * @returns the read container configuration
//      */
//     public static readFromYamlFile(correlationId: string, path: string, parameters: ConfigParams): ContainerConfig {
//         let config = YamlConfigReader.readConfig(correlationId, path, parameters);
//         return ContainerConfig.fromConfig(config);
//     }
		
// }