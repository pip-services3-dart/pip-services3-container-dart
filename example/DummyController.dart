import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';

class DummyController
    implements IReferenceable, IReconfigurable, IOpenable, INotifiable {
  FixedRateTimer _timer;
  final _logger = CompositeLogger();
  var _message = 'Hello World!';
  var _counter = 0;

  DummyController() {
    _timer = FixedRateTimer(this, 1000, 1000);
  }

  String get message {
    return _message;
  }

  set message(String value) {
    _message = value;
  }

  int get counter {
    return _counter;
  }

  set counter(int value) {
    _counter = value;
  }

  @override
  void configure(ConfigParams config) {
    message = config.getAsStringWithDefault('message', message);
  }

  @override
  void setReferences(IReferences references) {
    _logger.setReferences(references);
  }

  @override
  bool isOpen() {
    return _timer.isStarted();
  }

  @override
  Future open(String correlationId) async {
    try {
      _timer.start();
      _logger.trace(correlationId, 'Dummy controller opened');
    } catch (ex) {
      _logger.error(correlationId, ex, 'Failed to open Dummy container');

      rethrow;
    }
  }

  @override
  Future close(String correlationId) async {
    try {
      _timer.stop();
      _logger.trace(correlationId, 'Dummy controller closed');
    } catch (ex) {
      _logger.error(correlationId, ex, 'Failed to close Dummy container');
      rethrow;
    }
  }

  @override
  void notify(String correlationId, Parameters args) {
    _logger.info(correlationId, '%d - %s', [counter++, message]);
  }
}
