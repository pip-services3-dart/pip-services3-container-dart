import 'package:pip_services3_commons/pip_services3_commons.dart';
// import { Descriptor } from 'pip-services3-commons-node';
// import { TypeDescriptor } from 'pip-services3-commons-node';
// import { ConfigParams } from 'pip-services3-commons-node';
// import { ConfigException } from 'pip-services3-commons-node';

/// Configuration of a component inside a container.
///
/// The configuration includes type information or descriptor,
/// and component configuration parameters.

class ComponentConfig {
  /// Creates a new instance of the component configuration.
  ///
  /// - [descriptor]    (optional) a components descriptor (locator).
  /// - [type]          (optional) a components type descriptor.
  /// - [config]        (optional) component configuration parameters.
  ComponentConfig(
      [Descriptor? descriptor, TypeDescriptor? type, ConfigParams? config]) {
    this.descriptor = descriptor;
    this.type = type;
    this.config = config;
  }

  Descriptor? descriptor;
  TypeDescriptor? type;
  ConfigParams? config;

  /// Creates a new instance of ComponentConfig based on
  /// section from container configuration.
  ///
  /// - [config]    component parameters from container configuration
  /// Returns a newly created ComponentConfig
  ///
  /// Throws ConfigException when neither component descriptor or type is found.
  static ComponentConfig fromConfig(ConfigParams config) {
    var descriptor =
        Descriptor.fromString(config.getAsNullableString('descriptor'));
    var type = TypeDescriptor.fromString(config.getAsNullableString('type'));

    if (descriptor == null && type == null) {
      throw ConfigException(null, 'BAD_CONFIG',
          'Component configuration must have descriptor or type');
    }

    return ComponentConfig(descriptor, type, config);
  }
}
