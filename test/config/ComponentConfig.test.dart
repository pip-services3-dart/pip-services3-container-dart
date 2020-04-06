// let assert = require('chai').assert;

// import { ConfigParams } from 'pip-services3-commons-node';
// import { TypeDescriptor } from 'pip-services3-commons-node';
// import { Descriptor } from 'pip-services3-commons-node';

// import { ComponentConfig } from '../../src/config/ComponentConfig';

// suite('ComponentConfig', ()=> {
//     let componentConfig: ComponentConfig;

//     beforeEach(() => {
//         componentConfig = new ComponentConfig();
//     });

//     test('Type', () => {
//         assert.isUndefined(componentConfig.type);

//         let type: TypeDescriptor = new TypeDescriptor("new name", null);
//         componentConfig.type = type;
//         assert.equal(componentConfig.type, type);
//     });    

//     test('Descriptor', () => {
//         assert.isUndefined(componentConfig.descriptor);

//         let descriptor: Descriptor = new Descriptor("group", "type", "id", "default", "version");
//         componentConfig.descriptor = descriptor;
//         assert.equal(componentConfig.descriptor, descriptor);
//     });    

//     test('ConfigParams', () => {
//         assert.isUndefined(componentConfig.config);

//         let config: ConfigParams = ConfigParams.fromTuples(
//             "config.key", "key",
//             "config.key2", "key2"
//         );
//         componentConfig.config = config;
//         assert.equal(componentConfig.config, config);
//     });    

//     test('From Empty Config', () => {
//         let config: ConfigParams = ConfigParams.fromTuples();
//         try {
//             componentConfig = ComponentConfig.fromConfig(config);
//         } catch (ex) {
//             assert.equal(ex.message, "Component configuration must have descriptor or type");
//         }
//     });

//     test('From Wrong Config', () => {
//         let config: ConfigParams = ConfigParams.fromTuples(
//             "descriptor", "descriptor_name",
//             "type", "type",
//             "config.key", "key",
//             "config.key2", "key2");
//         try {
//             componentConfig = ComponentConfig.fromConfig(config);
//         } catch (ex) {
//             assert.equal(ex.message, "Descriptor descriptor_name is in wrong format");
//         }
//     });

//     test('From Correct Config', () => {
//         let descriptor: Descriptor = new Descriptor("group", "type", "id", "name", "version");
//         let type: TypeDescriptor = new TypeDescriptor("type", null);
//         let config: ConfigParams = ConfigParams.fromTuples(
//             "descriptor", "group:type:id:name:version",
//             "type", "type",
//             "config.key", "key",
//             "config.key2", "key2");

//         componentConfig = ComponentConfig.fromConfig(config);

//         assert.deepEqual(componentConfig.descriptor, descriptor);
//         assert.deepEqual(componentConfig.type, type);
//     });

// });
