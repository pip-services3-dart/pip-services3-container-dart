import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

/// Creates default container components (loggers, counters, caches, locks, etc.) by their descriptors.
///
/// See [Factory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/Factory-class.html) (in the PipServices 'Components' package)
/// See [DefaultInfoFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultInfoFactory-class.html) (in the PipServices 'Components' package)
/// See [DefaultLoggerFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultLoggerFactory-class.html) (in the PipServices 'Components' package)
/// See [DefaultCountersFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultCountersFactory-class.html) (in the PipServices 'Components' package)
/// See [DefaultConfigReaderFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultConfigReaderFactory-class.html) (in the PipServices 'Components' package)
/// See [DefaultCacheFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultCacheFactory-class.html) (in the PipServices 'Components' package)
/// See [DefaultCredentialStoreFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultCredentialStoreFactory-class.html) (in the PipServices 'Components' package)
/// See [DefaultDiscoveryFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultDiscoveryFactory-class.html) (in the PipServices 'Components' package)
/// See [DefaultTestFactory](https://pub.dev/documentation/pip_services3_components/latest/pip_services3_components/DefaultTestFactory-class.html) (in the PipServices 'Components' package)

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
    add(DefaultTracerFactory());
    add(DefaultConfigReaderFactory());
    add(DefaultCacheFactory());
    add(DefaultCredentialStoreFactory());
    add(DefaultDiscoveryFactory());
    add(DefaultTestFactory());
  }
}
