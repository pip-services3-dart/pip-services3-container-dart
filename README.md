# <img src="https://uploads-ssl.webflow.com/5ea5d3315186cf5ec60c3ee4/5edf1c94ce4c859f2b188094_logo.svg" alt="Pip.Services Logo" width="200"> <br/> IoC container for Dart

This module is a part of the [Pip.Services](http://pipservices.org) polyglot microservices toolkit. It provides an inversion-of-control (IoC) container to facilitate the development of services and applications composed of loosely coupled components.

The module containes a basic in-memory container that can be embedded inside a service or application, or can be run by itself.
The second container type can run as a system level process and can be configured via command line arguments.
Also it can be used to create docker containers.

The containers can read configuration from JSON or YAML files use it as a recipe for instantiating and configuring components.
Component factories are used to create components based on their locators (descriptor) defined in the container configuration.
The factories shall be registered in containers or dynamically in the container configuration file.

The module contains the following packages:
- **Core** - Basic in-memory and process containers
- **Build** - Default container factory
- **Config** - Container configuration components
- **Refer** - Inter-container reference management (implementation of the Referenceable pattern inside an IoC container)

<a name="links"></a> Quick links:

* [Configuration](https://www.pipservices.org/recipies/configuration) 
* [API Reference](https://pub.dev/documentation/pip_services3_container/latest/pip_services3_container/pip_services3_container-library.html)
* [Change Log](CHANGELOG.md)
* [Get Help](https://www.pipservices.org/community/help)
* [Contribute](https://www.pipservices.org/community/contribute)

## Use

Add this to your package's pubspec.yaml file:
```yaml
dependencies:
  pip_services3_container: version
```

Now you can install package from the command line:
```bash
pub get
```

Create a factory to create components based on their locators (descriptors).

```dart
import 'package:pip_services3_components/src/build/Factory.dart';
import 'package:pip_services3_commons/src/refer/Descriptor.dart';

class MyFactory extends Factory {
  static final MyComponentDescriptor =
      Descritor("myservice", "mycomponent", "default", "*", "1.0");

  MyFactory() : super() {
    this.registerAsType(MyFactory.MyComponentDescriptor, MyComponent);
  }
}

```

Then create a process container and register the factory there. You can also register factories defined in other
modules if you plan to include external components into your container.

```dart
import 'package:pip_services3_container/src/ProcessContainer.dart';
import 'package:pip_services3_rpc/src/build/DefaultRpcFactory.dart';

class MyProcess extends ProcessContainer {
  MyProcess():super('myservice', 'My service running as a process') {
    
    this._factories.add(DefaultRpcFactory());
    this._factories.add(MyFactory());
  }
}
```

Define YAML configuration file with components and their descriptors.
The configuration file is pre-processed using [Handlebars templating engine](https://handlebarsjs.com)
that allows to inject configuration parameters or dynamically include/exclude components using conditional blocks.
The values for the templating engine are defined via process command line arguments or via environment variables.
Support for environment variables works well in docker or other containers like AWS Lambda functions.

```yaml
---
# Context information
- descriptor: "pip-services:context-info:default:default:1.0"
  name: myservice
  description: My service running in a process container

# Console logger
- descriptor: "pip-services:logger:console:default:1.0"
  level: {{LOG_LEVEL}}{{^LOG_LEVEL}}info{{/LOG_LEVEL}}

# Performance counters that posts values to log
- descriptor: "pip-services:counters:log:default:1.0"
  
# My component
- descriptor: "myservice:mycomponent:default:default:1.0"
  param1: XYZ
  param2: 987
  
{{#if HTTP_ENABLED}}
# HTTP endpoint version 1.0
- descriptor: "pip-services:endpoint:http:default:1.0"
  connection:
    protocol: "http"
    host: "0.0.0.0"
    port: {{HTTP_PORT}}{{^HTTP_PORT}}8080{{/HTTP_PORT}}

 # Default Status
- descriptor: "pip-services:status-service:http:default:1.0"

# Default Heartbeat
- descriptor: "pip-services:heartbeat-service:http:default:1.0"
{{/if}}
```

To instantiate and run the container we need a simple process launcher.

```dart
void main(List<String> args) {
  try {
    var proc = MyProcess();
    proc.configPath = "./config/config.yml";
    proc.run(args);
  } catch (ex) {
    print(ex);
  }
}
```

And, finally, you can run your service launcher as
```bash
dart run ./service.dart
```

## Develop

For development you shall install the following prerequisites:
* Dart SDK 2
* Visual Studio Code or another IDE of your choice
* Docker

Install dependencies:
```bash
pub get
```

Run automated tests:
```bash
pub run test
```

Generate API documentation:
```bash
./docgen.ps1
```

Before committing changes run dockerized build and test as:
```bash
./build.ps1
./test.ps1
./clear.ps1
```

## Contacts

The Dart version of Pip.Services is created and maintained by:
- **Sergey Seroukhov**
- **Levichev Dmitry**

The documentation is written by:
- **Mark Makarychev**
- **Levichev Dmitry**
