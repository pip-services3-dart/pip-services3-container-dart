import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import './ReferencesDecorator.dart';

/// References decorator that automatically creates missing components using
/// available component factories upon component retrival.

class BuildReferencesDecorator extends ReferencesDecorator {
  /// Creates a new instance of the decorator.
  ///
  /// - [nextReferences] 		the next references or decorator in the chain.
  /// - [topReferences] 		the decorator at the top of the chain.
  BuildReferencesDecorator(
      IReferences nextReferences, IReferences topReferences)
      : super(nextReferences, topReferences);

  /// Finds a factory capable creating component by given descriptor
  /// from the components registered in the references.
  ///
  /// - [locator]   a locator of component to be created.
  /// Returns found factory or null if factory was not found.
  IFactory? findFactory(locator) {
    var components = getAll();
    for (var index = 0; index < components.length; index++) {
      var component = components[index];
      if (!(component is IFactory)) {
        continue;
      }
      if (component.canCreate is Function && component.create is Function) {
        if (component.canCreate(locator) != null) {
          return component;
        }
      }
    }

    return null;
  }

  /// Creates a component identified by given locator.
  ///
  /// - [locator] 	a locator to identify component to be created.
  /// - [factory]   a factory that shall create the component.
  /// Returns the created component.
  ///
  /// Throws a CreateException if the factory is not able to create the component.
  ///
  /// See [findFactory]
  dynamic create(locator, IFactory? factory) {
    if (factory == null) return null;

    try {
      // Create component
      return factory.create(locator);
    } catch (ex) {
      //print(ex);
      return null;
    }
  }

  /// Clarifies a component locator by merging two descriptors into one to replace missing fields.
  /// That allows to get a more complete descriptor that includes all possible fields.
  ///
  /// - [locator]   a component locator to clarify.
  /// - [factory]   a factory that shall create the component.
  /// Returns clarified component descriptor (locator)
  dynamic clarifyLocator(locator, IFactory? factory) {
    if (factory == null) return locator;
    if (!(locator is Descriptor)) return locator;

    var anotherLocator = factory.canCreate(locator);
    if (anotherLocator == null) return locator;
    if (!(anotherLocator is Descriptor)) return locator;

    var descriptor = locator;
    var anotherDescriptor = anotherLocator;

    return Descriptor(
        descriptor.getGroup() ?? anotherDescriptor.getGroup(),
        descriptor.getType() ?? anotherDescriptor.getType(),
        descriptor.getKind() ?? anotherDescriptor.getKind(),
        descriptor.getName() ?? anotherDescriptor.getName(),
        descriptor.getVersion() ?? anotherDescriptor.getVersion());
  }

  /// Gets all component references that match specified locator.
  ///
  /// - [locator] 	the locator to find a reference by.
  /// - [required] 	forces to raise an exception if no reference is found.
  /// Returns a list with matching component references.
  ///
  /// Throws a [ReferenceException] when required is set to true but no references found.
  @override
  List<T> find<T>(locator, bool required) {
    var components = super.find<T>(locator, false);

    // Try to create the component
    if (required && components.isEmpty) {
      var factory = findFactory(locator);
      var component = create(locator, factory);
      if (component != null) {
        try {
          locator = clarifyLocator(locator, factory);
          topReferences!.put(locator, component);
          components.add(component);
        } catch (ex) {
          // Ignore exception
        }
      }
    }

    // Throw exception is no required components found
    if (required && components.isEmpty) {
      throw ReferenceException(null, locator.toString());
    }

    return components;
  }
}
