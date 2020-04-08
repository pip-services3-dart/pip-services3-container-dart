import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services3_components/pip_services3_components.dart';

import '../config/ContainerConfig.dart';
import './ManagedReferences.dart';

/// Container managed references that can be created from container configuration.
///
/// See [[ManagedReferences]]

class ContainerReferences extends ManagedReferences {
  ContainerReferences(List tuples) : super(tuples);

  /// Puts components into the references from container configuration.
  ///
  /// -   config  a container configuration with information of components to be added.
  ///
  /// Throws CreateException when one of component cannot be created.

  void putFromConfig(ContainerConfig config) {
    for (var i = 0; i < config.length; i++) {
      var componentConfig = config[i];
      var component;
      var locator;

      try {
        // Create component dynamically
        if (componentConfig.type != null) {
          locator = componentConfig.type;
          component = TypeReflector.createInstanceByDescriptor(
              componentConfig.type, []);
          // Or create component statically
        } else if (componentConfig.descriptor != null) {
          locator = componentConfig.descriptor;
          var factory = builder.findFactory(locator);
          component = builder.create(locator, factory);
          if (component == null) {
            throw ReferenceException(null, locator);
          }
          locator = builder.clarifyLocator(locator, factory);
        }

        // Check that component was created
        if (component == null) {
          throw CreateException(
                  'CANNOT_CREATE_COMPONENT', 'Cannot create component')
              .withDetails('config', config);
        }

        // Add component to the list
        references.put(locator, component);

        if (component is IConfigurable) {
          //component.configure != null
          // Configure component
          var configurable = component as IConfigurable;
          configurable.configure(componentConfig.config);
        }

        // Set references to factories
        if (component is IFactory) {
          // component.canCreate != null && component.create != null
          var referenceable = component as IReferenceable;
          referenceable.setReferences(this);
        }
      } catch (ex) {
        throw ReferenceException(null, locator).withCause(ex);
      }
    }
  }
}
