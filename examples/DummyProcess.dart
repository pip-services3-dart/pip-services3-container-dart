import '../lib/src/ProcessContainer.dart';
import './DummyFactory.dart';

class DummyProcess extends ProcessContainer {

    DummyProcess():super('dummy', 'Sample dummy process') {
        configPath = './config/dummy.yaml';
        factories.add(DummyFactory());
    }

}
