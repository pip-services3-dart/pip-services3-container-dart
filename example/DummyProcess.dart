import 'package:pip_services3_container/pip_services3_container.dart';
import './DummyFactory.dart';

class DummyProcess extends ProcessContainer {

    DummyProcess():super('dummy', 'Sample dummy process') {
        configPath = './config/dummy.yaml';
        factories.add(DummyFactory());
    }
}
