/// See full source on GitHub
/// [https://github.com/pip-services3-dart/pip-services3-container-dart/tree/master/examples]
/// See configuration file (dummy.yaml) in ./config dir
///

import '../example/DummyProcess.dart';

void main(List<String> arguments) {
  try {
    DummyProcess().run(arguments);
  } catch (ex) {
    print(ex);
  }
}
