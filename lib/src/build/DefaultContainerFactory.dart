import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

/// Creates default container components (loggers, counters, caches, locks, etc.) by their descriptors.
///
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/build.factory.html Factory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/info.defaultinfofactory.html DefaultInfoFactory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/log.defaultloggerfactory.html DefaultLoggerFactory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/count.defaultcountersfactory.html DefaultCountersFactory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/config.defaultconfigreaderfactory.html DefaultConfigReaderFactory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/cache.defaultcachefactory.html DefaultCacheFactory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/auth.defaultcredentialstorefactory.html DefaultCredentialStoreFactory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/connect.defaultdiscoveryfactory.html DefaultDiscoveryFactory]] (in the PipServices 'Components' package)
/// See [[https://rawgit.com/pip-services-node/pip-services3-components-node/master/doc/api/classes/test.defaulttestfactory.html DefaultTestFactory]] (in the PipServices 'Components' package)

class DefaultContainerFactory extends CompositeFactory {
  static final descriptor =
      Descriptor('pip-services', 'factory', 'container', 'default', '1.0');

  /// Create a new instance of the factory and sets nested factories.
  ///
  /// - [factories]     a list of nested factories
  DefaultContainerFactory(List<IFactory> factories) : super(factories) {
    add(DefaultInfoFactory());
    add(DefaultLoggerFactory());
    add(DefaultCountersFactory());
    add(DefaultConfigReaderFactory());
    add(DefaultCacheFactory());
    add(DefaultCredentialStoreFactory());
    add(DefaultDiscoveryFactory());
    add(DefaultTestFactory());
  }
}
