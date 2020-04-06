import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../../lib/src/config/ComponentConfig.dart';

void main() {
  group('ComponentConfig', () {
    ComponentConfig componentConfig;

    componentConfig = ComponentConfig();

    test('Type', () {
      expect(componentConfig.type, isNull);

      var type = TypeDescriptor('new name', null);
      componentConfig.type = type;
      expect(componentConfig.type, type);
    });

    componentConfig = ComponentConfig();
    test('Descriptor', () {
      expect(componentConfig.descriptor, isNull);

      var descriptor = Descriptor('group', 'type', 'id', 'default', 'version');
      componentConfig.descriptor = descriptor;
      expect(componentConfig.descriptor, descriptor);
    });

    componentConfig = ComponentConfig();
    test('ConfigParams', () {
      expect(componentConfig.config, isNull);

      var config =
          ConfigParams.fromTuples(['config.key', 'key', 'config.key2', 'key2']);
      componentConfig.config = config;
      expect(componentConfig.config, config);
    });

    componentConfig = ComponentConfig();
    test('From Empty Config', () {
      var config = ConfigParams.fromTuples([]);
      try {
        componentConfig = ComponentConfig.fromConfig(config);
      } catch (ex) {
        expect(
            ex.message, 'Component configuration must have descriptor or type');
      }
    });
    componentConfig = ComponentConfig();

    test('From Wrong Config', () {
      var config = ConfigParams.fromTuples([
        'descriptor',
        'descriptor_name',
        'type',
        'type',
        'config.key',
        'key',
        'config.key2',
        'key2'
      ]);
      try {
        componentConfig = ComponentConfig.fromConfig(config);
      } catch (ex) {
        expect(ex.message, 'Descriptor descriptor_name is in wrong format');
      }
    });

    componentConfig = ComponentConfig();
    test('From Correct Config', () {
      var descriptor = Descriptor('group', 'type', 'id', 'name', 'version');
      var type = TypeDescriptor('type', null);
      var config = ConfigParams.fromTuples([
        'descriptor',
        'group:type:id:name:version',
        'type',
        'type',
        'config.key',
        'key',
        'config.key2',
        'key2'
      ]);

      componentConfig = ComponentConfig.fromConfig(config);

      expect(componentConfig.descriptor, descriptor); //deepEqual
      expect(componentConfig.type.equals(type), isTrue); //deepEqual
    });
  });
}
