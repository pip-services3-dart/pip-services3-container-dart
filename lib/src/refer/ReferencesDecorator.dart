import 'package:pip_services3_commons/pip_services3_commons.dart';

/// Chainable decorator for IReferences that allows to inject additional capabilities
/// such as automatic component creation, automatic registration and opening.
///
/// See [IReferences](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IReferences-class.html) (in the PipServices "Commons" package)

class ReferencesDecorator implements IReferences {
  /// Creates a new instance of the decorator.
  ///
  /// - nextReferences 		the next references or decorator in the chain.
  /// - topReferences 		the decorator at the top of the chain.

  ReferencesDecorator(IReferences nextReferences, IReferences topReferences) {
    this.nextReferences = nextReferences ?? topReferences;
    this.topReferences = topReferences ?? nextReferences;
  }

  /// The next references or decorator in the chain.
  IReferences nextReferences;

  /// The decorator at the top of the chain.
  IReferences topReferences;

  /// Puts a new reference into this reference map.
  ///
  /// - [locator] 	a locator to find the reference by.
  /// - [component] a component reference to be added.
  @override
  dynamic put(locator, component) {
    return nextReferences.put(locator, component);
  }

  /// Removes a previously added reference that matches specified locator.
  /// If many references match the locator, it removes only the first one.
  /// When all references shall be removed, use [removeAll] method instead.
  ///
  /// - [locator] 	a locator to remove reference
  /// Returns the removed component reference.
  ///
  /// See [removeAll]

  @override
  dynamic remove(locator) {
    return nextReferences.remove(locator);
  }

  /// Removes all component references that match the specified locator.
  ///
  /// - [locator] 	the locator to remove references by.
  /// Returns a list, containing all removed references.

  @override
  List removeAll(locator) {
    return nextReferences.removeAll(locator);
  }

  /// Gets locators for all registered component references in this reference map.
  ///
  /// Returns a list with component locators.
  @override
  List getAllLocators() {
    return nextReferences.getAllLocators();
  }

  /// Gets all component references registered in this reference map.
  ///
  /// Returns a list with component references.
  @override
  List getAll() {
    return nextReferences.getAll();
  }

  /// Gets an optional component reference that matches specified locator.
  ///
  /// - [locator] 	the locator to find references by.
  /// Returns a matching component reference or null if nothing was found.

  @override
  T getOneOptional<T>(locator) {
    try {
      var components = find<T>(locator, false);
      return components.isNotEmpty ? components[0] : null;
    } catch (ex) {
      return null;
    }
  }

  /// Gets a required component reference that matches specified locator.
  ///
  /// - [locator] 	the locator to find a reference by.
  /// Returns a matching component reference.
  /// Throws a [ReferenceException] when no references found.
  @override
  T getOneRequired<T>(locator) {
    var components = find<T>(locator, true);
    return components.isNotEmpty ? components[0] : null;
  }

  /// Gets all component references that match specified locator.
  ///
  /// - [locator] 	the locator to find references by.
  /// Returns a list with matching component references or empty list if nothing was found.
  @override
  List<T> getOptional<T>(locator) {
    try {
      return find<T>(locator, false);
    } catch (ex) {
      return [];
    }
  }

  /// Gets all component references that match specified locator.
  /// At least one component reference must be present.
  /// If it doesn't the method throws an error.
  ///
  /// - [locator] 	the locator to find references by.
  /// Returns a list with matching component references.
  ///
  /// Throws a [ReferenceException] when no references found.
  @override
  List<T> getRequired<T>(locator) {
    return find<T>(locator, true);
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
    return nextReferences.find<T>(locator, required);
  }
}
