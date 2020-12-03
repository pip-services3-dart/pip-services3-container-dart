import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import './ReferencesDecorator.dart';

/// References decorator that automatically opens to newly added components
/// that implement [IOpenable interface](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IOpenable-class.html) and closes removed components
/// that implement [IClosable interface](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/IClosable-class.html).

class RunReferencesDecorator extends ReferencesDecorator implements IOpenable {
  bool opened = false;

  /// Creates a new instance of the decorator.
  ///
  /// - [nextReferences] 		the next references or decorator in the chain.
  /// - [topReferences] 		the decorator at the top of the chain.

  RunReferencesDecorator(IReferences nextReferences, IReferences topReferences)
      : super(nextReferences, topReferences);

  /// Checks if the component is opened.
  ///
  /// Returns true if the component has been opened and false otherwise.
  @override
  bool isOpen() {
    return opened;
  }

  /// Opens the component.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			Future that receives null no errors occured.
  /// Throws error
  @override
  Future open(String correlationId) async {
    if (!opened) {
      var components = getAll();
      await Opener.open(correlationId, components);

      opened = true;
    }
  }

  /// Closes component and frees used resources.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			Future that receives null no errors occured.
  /// Throws error
  @override
  Future close(String correlationId) async {
    if (opened) {
      var components = getAll();
      await Closer.close(correlationId, components);
      opened = false;
    }
  }

  /// Puts a new reference into this reference map.
  ///
  /// - [locator] 	a locator to find the reference by.
  /// - [component] a component reference to be added.
  @override
  void put(locator, component) {
    super.put(locator, component);

    if (opened) {
      Opener.openOne(null, component);
    }
  }

  /// Removes a previously added reference that matches specified locator.
  /// If many references match the locator, it removes only the first one.
  /// When all references shall be removed, use [removeAll] method instead.
  ///
  /// - locator 	a locator to remove reference
  /// Returns the removed component reference.
  ///
  /// See [removeAll]
  @override
  dynamic remove(locator) {
    var component = super.remove(locator);

    if (opened) {
      Closer.closeOne(null, component);
    }
    return component;
  }

  /// Removes all component references that match the specified locator.
  ///
  /// - locator 	the locator to remove references by.
  /// Returns a list, containing all removed references.
  @override
  List removeAll(locator) {
    var components = super.removeAll(locator);

    if (opened) {
      Closer.close(null, components);
    }

    return components;
  }
}
