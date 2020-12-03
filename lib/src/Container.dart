import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';

import './build/DefaultContainerFactory.dart';
import './config/ContainerConfig.dart';
import './config/ContainerConfigReader.dart';
import './refer/ContainerReferences.dart';

/// Inversion of control (IoC) container that creates components and manages their lifecycle.
///
/// The container is driven by configuration, that usually stored in JSON or YAML file.
/// The configuration contains a list of components identified by type or locator, followed
/// by component configuration.
///
/// On container start it performs the following actions:
/// - Creates components using their types or calls registered factories to create components using their locators
/// - Configures components that implement [IConfigurable interface](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IConfigurable-class.html) and passes them their configuration parameters
/// - Sets references to components that implement [IReferenceable interface](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IReferenceable-class.html) and passes them references of all components in the container
/// - Opens components that implement [IOpenable interface](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IOpenable-class.html)
///
/// On container stop actions are performed in reversed order:
/// - Closes components that implement [IClosable interface](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IClosable-class.html)
/// - Unsets references in components that implement [IUnreferenceable interface](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IUnreferenceable-class.html)
/// - Destroys components in the container.
///
/// The component configuration can be parameterized by dynamic values. That allows specialized containers
/// to inject parameters from command line or from environment variables.
///
/// The container automatically creates a ContextInfo component that carries detail information
/// about the container and makes it available for other components.
///
/// See [IConfigurable](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IConfigurable-class.html) (in the PipServices 'Commons' package)
/// See [IReferenceable](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IReferenceable-class.html) (in the PipServices 'Commons' package)
/// See [IOpenable](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IOpenable-class.html) (in the PipServices 'Commons' package)
///
/// ### Configuration parameters ###
///
/// - name: 					the context (container or process) name
/// - description: 		   	human-readable description of the context
/// - properties: 			    entire section of additional descriptive properties
/// 	   - ...
///
/// ### Example ###
///
///     ======= config.yml ========
///     - descriptor: mygroup:mycomponent1:default:default:1.0
///       param1: 123
///       param2: ABC
///
///     - type: mycomponent2,mypackage
///       param1: 321
///       param2: XYZ
///     ============================
///
///     var container = new Container();
///     container.addFactory(new MyComponentFactory());
///
///     var parameters = ConfigParams.fromValue(process.env);
///     container.readConfigFromFile('123', './config/config.yml', parameters);
///
///     container.open('123', (err) => {
///         console.log('Container is opened');
///         ...
///         container.close('123', (err) => {
///             console.log('Container is closed');
///         });
///     });

class Container
    implements IConfigurable, IReferenceable, IUnreferenceable, IOpenable {
  ILogger logger = NullLogger();
  DefaultContainerFactory factories = DefaultContainerFactory([]);
  ContextInfo info;
  ContainerConfig config;
  ContainerReferences references;

  /// Creates a new instance of the container.
  ///
  /// - [name]          (optional) a container name (accessible via ContextInfo)
  /// - [description]   (optional) a container description (accessible via ContextInfo)

  Container([String name, String description]) {
    // Override in child classes
    info = ContextInfo(name, description);
  }

  /// Configures component by passing configuration parameters.
  ///
  /// - [config]    configuration parameters to be set.
  @override
  void configure(ConfigParams config) {
    this.config = ContainerConfig.fromConfig(config);
  }

  /// Reads container configuration from JSON or YAML file
  /// and parameterizes it with given values.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [path]              a path to configuration file
  /// - [parameters]        values to parameters the configuration or null to skip parameterization.

  void readConfigFromFile(
      String correlationId, String path, ConfigParams parameters) async {
    config = await ContainerConfigReader.readFromFile(
        correlationId, path, parameters);
    logger.trace(correlationId, config.toString());
  }

  /// Sets references to dependent components.
  ///
  /// - references 	references to locate the component dependencies.

  @override
  void setReferences(IReferences references) {
    // Override in child classes
  }

  /// Unsets (clears) previously set references to dependent components.

  @override
  void unsetReferences() {
    // Override in child classes
  }

  void _initReferences(IReferences references) {
    var existingInfo = references
        .getOneOptional<ContextInfo>(DefaultInfoFactory.ContextInfoDescriptor);
    if (existingInfo == null) {
      references.put(DefaultInfoFactory.ContextInfoDescriptor, info);
    } else {
      info = existingInfo;
    }

    references.put(DefaultContainerFactory.descriptor, factories);
  }

  /// Adds a factory to the container. The factory is used to create components
  /// added to the container by their locators (descriptors).
  ///
  /// - [factory] a component factory to be added.

  void addFactory(IFactory factory) {
    factories.add(factory);
  }

  /// Checks if the component is opened.
  ///
  /// Returns true if the component has been opened and false otherwise.

  @override
  bool isOpen() {
    return references != null;
  }

  /// Opens the component.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			Future that receives null no errors occured.
  /// Throws error

  @override
  Future open(String correlationId) async {
    if (references != null) {
      var err = InvalidStateException(
          correlationId, 'ALREADY_OPENED', 'Container was already opened');
      throw err;
    }

    try {
      logger.trace(correlationId, 'Starting container.');

      // Create references with configured components
      references = ContainerReferences([]);
      _initReferences(references);
      references.putFromConfig(config);
      setReferences(references);

      // Get custom description if available
      var infoDescriptor = Descriptor('*', 'context-info', '*', '*', '*');
      info = references.getOneOptional<ContextInfo>(infoDescriptor);
      try {
        await references.open(correlationId);

        // Get reference to logger
        logger = CompositeLogger(references);
        logger.info(correlationId, 'Container %s started.', [info.name]);
        return null;
      } catch (err) {
        logger.fatal(correlationId, err, 'Failed to start container');
        await close(correlationId);
      }
    } catch (ex) {
      logger.fatal(correlationId, ex, 'Failed to start container');

      await close(correlationId);
    }
  }

  /// Closes component and frees used resources.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return			        Future that receives null no errors occured.
  /// Throws

  @override
  Future close(String correlationId) async {
    // Skip if container wasn't opened
    if (references == null) {
      return null;
    }

    try {
      logger.trace(correlationId, 'Stopping %s container', [info.name]);

      // Unset references for child container
      unsetReferences();

      // Close and dereference components
      try {
        await references.close(correlationId);
      } catch (err) {
        references = null;
        logger.info(correlationId, 'Container %s stopped', [info.name]);
        return null;
      }
    } catch (ex) {
      logger.error(correlationId, ex, 'Failed to stop container');
      rethrow;
    }
  }
}
