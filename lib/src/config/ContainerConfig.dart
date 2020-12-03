import 'dart:collection';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import './ComponentConfig.dart';

/// Container configuration defined as a list of component configurations.
///
/// See [ComponentConfig]

class ContainerConfig extends ListBase<ComponentConfig> {
  final _values = <ComponentConfig>[];

  /// Creates a new instance of container configuration.
  ///
  /// - [components]    (optional) a list of component configurations.
  ContainerConfig([List<ComponentConfig> components]) : super() {
    if (components != null) {
      super.addAll(components);
    }
  }

  /// Creates a new ContainerConfig object filled with key-value pairs from specified object.
  /// The value is converted into ConfigParams object which is used to create the object.
  ///
  /// - [value]		an object with key-value pairs used to initialize a new ContainerConfig.
  /// Returns			a new ContainerConfig object.
  ///
  /// See [fromConfig]
  static ContainerConfig fromValue(value) {
    var config = ConfigParams.fromValue(value);
    return ContainerConfig.fromConfig(config);
  }

  /// Creates a new ContainerConfig object based on configuration parameters.
  /// Each section in the configuration parameters is converted into a component configuration.
  ///
  /// - [value]		an object with key-value pairs used to initialize a new ContainerConfig.
  /// Returns			a new ContainerConfig object.
  static ContainerConfig fromConfig(ConfigParams config) {
    var result = ContainerConfig();
    if (config == null) return result;

    var names = config.getSectionNames();
    for (var i = 0; i < names.length; i++) {
      var componentConfig = config.getSection(names[i]);
      result.add(ComponentConfig.fromConfig(componentConfig));
    }

    return result;
  }

  @override
  int get length {
    return _values.length;
  }

  @override
  set length(int l) {
    _values.length = l;
  }

  @override
  ComponentConfig operator [](int index) {
    return _values[index];
  }

  @override
  void operator []=(int index, ComponentConfig value) {
    _values[index] = value;
  }
}
