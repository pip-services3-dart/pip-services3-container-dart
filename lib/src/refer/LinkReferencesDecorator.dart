import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import './ReferencesDecorator.dart';

/// References decorator that automatically sets references to newly added components
/// that implement [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/refer.ireferenceable.html IReferenceable interface]] and unsets references from removed components
/// that implement [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/refer.iunreferenceable.html IUnreferenceable interface]].

class LinkReferencesDecorator extends ReferencesDecorator implements IOpenable {
  bool _opened = false;

  /// Creates a new instance of the decorator.
  ///
  /// - [nextReferences] 		the next references or decorator in the chain.
  /// - [topReferences] 		the decorator at the top of the chain.
  LinkReferencesDecorator(IReferences nextReferences, IReferences topReferences)
      : super(nextReferences, topReferences);

  /// Checks if the component is opened.
  ///
  /// Returns true if the component has been opened and false otherwise.
  @override
  bool isOpen() {
    return _opened;
  }

  /// Opens the component.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			Future that receives null no errors occured.
  /// Throws error
  @override
  Future open(String correlationId) async {
    if (!_opened) {
      _opened = true;
      var components = getAll();
      Referencer.setReferences(topReferences, components);
    }
  }

  /// Closes component and frees used resources.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			Future that receives null no errors occured.
  /// Throws error
  @override
  Future close(String correlationId) async {
    if (_opened) {
      _opened = false;
      var components = getAll();
      Referencer.unsetReferences(components);
    }
  }

  /// Puts a new reference into this reference map.
  ///
  /// - [locator] 	a locator to find the reference by.
  /// - component a component reference to be added.
  @override
  dynamic put(locator, component) {
    super.put(locator, component);

    if (_opened) {
      Referencer.setReferencesForOne(topReferences, component);
    }
  }

  /// Removes a previously added reference that matches specified locator.
  /// If many references match the locator, it removes only the first one.
  /// When all references shall be removed, use [[removeAll]] method instead.
  ///
  /// - [locator] 	a locator to remove reference
  /// Returns the removed component reference.
  ///
  /// See [[removeAll]]
  @override
  dynamic remove(locator) {
    var component = super.remove(locator);

    if (_opened) {
      Referencer.unsetReferencesForOne(component);
    }

    return component;
  }

  /// Removes all component references that match the specified locator.
  ///
  /// - [locator] 	the locator to remove references by.
  /// Returns a list, containing all removed references.
  @override
  List removeAll(locator) {
    var components = super.removeAll(locator);

    if (_opened) {
      Referencer.unsetReferences(components);
    }

    return components;
  }
}
