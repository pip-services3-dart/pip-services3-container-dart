import 'dart:async';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import './ContainerConfig.dart';

/// Helper class that reads container configuration from JSON or YAML file.

class ContainerConfigReader {
  /// Reads container configuration from JSON or YAML file.
  /// The type of the file is determined by file extension.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [path]              a path to component configuration file.
  /// - [parameters]        values to parameters the configuration or null to skip parameterization.
  /// Returns the read container configuration
  static Future<ContainerConfig> readFromFile(
      String correlationId, String path, ConfigParams parameters) async {
    if (path == null) {
      throw ConfigException(
          correlationId, 'NO_PATH', 'Missing config file path');
    }

    var ext = path.split('.').last; //.pop();

    if (ext == 'json') {
      return await ContainerConfigReader.readFromJsonFile(
          correlationId, path, parameters);
    }

    if (ext == 'yaml' || ext == 'yml') {
      return await ContainerConfigReader.readFromYamlFile(
          correlationId, path, parameters);
    }

    // By default read as JSON
    return await ContainerConfigReader.readFromJsonFile(
        correlationId, path, parameters);
  }

  /// Reads container configuration from JSON file.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [path]              a path to component configuration file.
  /// - [parameters]        values to parameters the configuration or null to skip parameterization.
  /// Returns the read container configuration
  static Future<ContainerConfig> readFromJsonFile(
      String correlationId, String path, ConfigParams parameters) async {
    var config = await JsonConfigReader.readConfig_(correlationId, path, parameters);
    return ContainerConfig.fromConfig(config);
  }

  /// Reads container configuration from YAML file.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [path]              a path to component configuration file.
  /// - [parameters]        values to parameters the configuration or null to skip parameterization.
  /// Returns the read container configuration
  static Future<ContainerConfig> readFromYamlFile(
      String correlationId, String path, ConfigParams parameters) async {
    var config = await YamlConfigReader.readConfig_(correlationId, path, parameters);
    return ContainerConfig.fromConfig(config);
  }
}
