//var process = require('process');
import 'dart:io';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import './Container.dart';

/// Inversion of control (IoC) container that runs as a system process.
/// It processes command line arguments and handles unhandled exceptions and Ctrl-C signal
/// to gracefully shutdown the container.
///
/// ### Command line arguments ###
/// - [--config / -c]             path to JSON or YAML file with container configuration (default: './config/config.yml')
/// - [--param / --params / -p]   value(s) to parameterize the container configuration
/// - [--help / -h]               prints the container usage help
///
/// See [[Container]]
///
/// ### Example ###
///
///     var container = new ProcessContainer();
///     container.addFactory(MyComponentFactory());
///
///     container.run(process.args);

class ProcessContainer extends Container {
  String configPath = './config/config.yml';

  /// Creates a new instance of the container.
  ///
  /// - name          (optional) a container name (accessible via ContextInfo)
  /// - description   (optional) a container description (accessible via ContextInfo)

  ProcessContainer([String name, String description])
      : super(name, description) {
    logger = ConsoleLogger();
  }

  String _getConfigPath(List<String> args) {
    for (var index = 0; index < args.length; index++) {
      var arg = args[index];
      var nextArg = index < args.length - 1 ? args[index + 1] : null;
      nextArg = nextArg != null && nextArg.startsWith('-') ? null : nextArg;
      if (nextArg != null) {
        if (arg == '--config' || arg == '-c') {
          return nextArg;
        }
      }
    }
    return configPath;
  }

  ConfigParams _getParameters(List<String> args) {
    // Process command line parameters
    var line = '';
    for (var index = 0; index < args.length; index++) {
      var arg = args[index];
      var nextArg = index < args.length - 1 ? args[index + 1] : null;
      nextArg = nextArg != null && nextArg.startsWith('-') ? null : nextArg;
      if (nextArg != null) {
        if (arg == '--param' || arg == '--params' || arg == '-p') {
          if (line.isNotEmpty) {
            line = line + ';';
          }
          line = line + nextArg;
          index++;
        }
      }
    }
    var parameters = ConfigParams.fromString(line);

    // Process environmental variables
    parameters.append(Platform.environment);

    return parameters;
  }

  bool _showHelp(List<String> args) {
    for (var index = 0; index < args.length; index++) {
      var arg = args[index];
      if (arg == '--help' || arg == '-h') {
        return true;
      }
    }
    return false;
  }

  void _printHelp() {
    print(
        'Pip.Services process container - http://www.github.com/pip-services/pip-services');
    print('run [-h] [-c <config file>] [-p <param>=<value>]*');
  }

  void _captureExit(String correlationId) async {
    logger.info(correlationId, 'Press Control-C to stop the microservice...');

    // Activate graceful exit
    ProcessSignal.sigint.watch().listen((signal) {
      // if (Platform.operatingSystem.toLowerCase().contains('windows') ||
      //     Platform.operatingSystem.toLowerCase().contains('macos')) {
      close(correlationId);
      logger.info(correlationId, 'Goodbye!');
      //}
      exit(0);
    });

    // Temporary exclude this code because  SigQuit not supported in Dart
    // Gracefully shutdown
    // if (!Platform.operatingSystem.toLowerCase().contains('windows') &&
    //     !Platform.operatingSystem.toLowerCase().contains('macos')) {
    //   ProcessSignal.sigquit.watch().listen((signal) {
    //     close(correlationId);
    //     logger.info(correlationId, 'Goodbye!');
    //     exit(0);
    //   });
    // }
  }

  /// Runs the container by instantiating and running components inside the container.
  ///
  /// It reads the container configuration, creates, configures, references and opens components.
  /// On process exit it closes, unreferences and destroys components to gracefully shutdown.
  ///
  /// - args  command line arguments

  void run(List<String> args) async {
    if (_showHelp(args)) {
      _printHelp();
      return;
    }

    var correlationId = info.name;
    try {
      var path = _getConfigPath(args);
      var parameters = _getParameters(args);
      await readConfigFromFile(correlationId, path, parameters);

      _captureExit(correlationId);

      await open(correlationId);
    } catch (ex) {
      // Log uncaught exceptions
      var err = ApplicationException().wrap(ex);
      logger.fatal(correlationId, err, 'Process is terminated', []);
      exit(1);
    }
  }
}
