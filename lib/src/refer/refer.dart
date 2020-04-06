/** 
 * @module refer 
 * 
 * Todo: Rewrite the description.
 * 
 * @preferred
 * Provides the inversion of control design pattern but does not contain the fully 
 * functional container (we can just only create a class that will set various references).
 * 
 * Once the objects of a container are configured, if they implement the [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/refer.ireferenceable.html IReferencable interface]], 
 * they are passed a set of references for recreating links between objects in the container. If 
 * objects implement the [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/run.iopenable.html IOpenable interface]], 
 * the <code>open()</code> method is called and they 
 * start to work. Connections to various services are made, after which the objects start, the 
 * container starts running, and the objects carry out their tasks. When the container 
 * starts to close, the objects that implement the [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/run.iclosable.html ICloseable interface]] 
 * are closed via their 
 * <code>close()</code> method (which should make them stop working and disconnect from other services), 
 * after which objects that implement the [[https://rawgit.com/pip-services-node/pip-services3-commons-node/master/doc/api/interfaces/refer.iunreferenceable.html IUnreferencable interface]] 
 * delete various links between objects, and, finally, the contains destroys all objects and turns off. 
 * 
 * [[BuildReferencesDecorator Build]], [[LinkReferencesDecorator Link]], and 
 * [[RunReferencesDecorator Run]] - ReferenceDecorators are used during the corresponding 
 * building, linking, and running stages and are united in [[ManagedReferences]], which 
 * are extended by [[ContainerReferences]].
*/
export './ContainerReferences.dart';

export './ReferencesDecorator.dart';
export './BuildReferencesDecorator.dart';
export './LinkReferencesDecorator.dart';
export './RunReferencesDecorator.dart';
export './ManagedReferences.dart';