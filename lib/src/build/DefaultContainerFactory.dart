// /** @module build */
// import { IFactory } from 'pip-services3-components-node';
// import { CompositeFactory } from 'pip-services3-components-node';
// import { DefaultLoggerFactory } from 'pip-services3-components-node';
// import { DefaultCountersFactory } from 'pip-services3-components-node';
// import { DefaultConfigReaderFactory } from 'pip-services3-components-node';
// import { DefaultCacheFactory } from 'pip-services3-components-node';
// import { DefaultCredentialStoreFactory } from 'pip-services3-components-node';
// import { DefaultDiscoveryFactory } from 'pip-services3-components-node';
// import { DefaultInfoFactory } from 'pip-services3-components-node';
// import { DefaultTestFactory } from 'pip-services3-components-node';
// import { Descriptor } from 'pip-services3-commons-node';

// /**
//  * Creates default container components (loggers, counters, caches, locks, etc.) by their descriptors.
//  * 
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/build.factory.html Factory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/info.defaultinfofactory.html DefaultInfoFactory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/log.defaultloggerfactory.html DefaultLoggerFactory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/count.defaultcountersfactory.html DefaultCountersFactory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/config.defaultconfigreaderfactory.html DefaultConfigReaderFactory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/cache.defaultcachefactory.html DefaultCacheFactory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/auth.defaultcredentialstorefactory.html DefaultCredentialStoreFactory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/connect.defaultdiscoveryfactory.html DefaultDiscoveryFactory]] (in the PipServices "Components" package)
//  * @see [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/test.defaulttestfactory.html DefaultTestFactory]] (in the PipServices "Components" package)
//  */
// export class DefaultContainerFactory extends CompositeFactory {
//     public static readonly Descriptor: Descriptor = new Descriptor("pip-services", "factory", "container", "default", "1.0");

//     /**
// 	 * Create a new instance of the factory and sets nested factories.
//      * 
//      * @param factories     a list of nested factories
// 	 */
//     public constructor(...factories: IFactory[]) {
//         super(...factories);

//         this.add(new DefaultInfoFactory());
//         this.add(new DefaultLoggerFactory());
//         this.add(new DefaultCountersFactory());
//         this.add(new DefaultConfigReaderFactory());
//         this.add(new DefaultCacheFactory());
//         this.add(new DefaultCredentialStoreFactory());
//         this.add(new DefaultDiscoveryFactory());
//         this.add(new DefaultTestFactory());
//     }

// }
