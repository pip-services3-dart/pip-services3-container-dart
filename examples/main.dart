import './DummyProcess.dart';

void main(List<String> arguments) {
  try {
    DummyProcess().run(arguments);
  } catch (ex) {
    print(ex);
  }
}
