import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';

import '../../lib/src/refer/ManagedReferences.dart';

void main() {
  group('ManagedReferences', () {
    test('Auto Create Component', () {
      var refs = ManagedReferences([]);

      var factory = DefaultLoggerFactory();
      refs.put(null, factory);

      var logger = refs
          .getOneRequired<ILogger>(Descriptor('*', 'logger', '*', '*', '*'));
      expect(logger, isNotNull);
    });

    test('String Locator', () {
      var refs = ManagedReferences([]);

      var factory = DefaultLoggerFactory();
      refs.put(null, factory);

      var component = refs.getOneOptional('ABC');
      expect(component, isNull);
    });

    test('Null Locator', () {
      var refs = ManagedReferences([]);

      var factory = DefaultLoggerFactory();
      refs.put(null, factory);

      var component = refs.getOneOptional(null);
      expect(component, isNull);
    });
  });
}
