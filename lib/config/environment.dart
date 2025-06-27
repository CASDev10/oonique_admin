enum AppEnv { dev, prod, local }

abstract class Environment {
  String name;
  String baseUrl;

  Environment({required this.baseUrl, required this.name});

  factory Environment.fromEnv(AppEnv appEnv) {
    if (appEnv == AppEnv.local) {
      return LocalEnvironment();
    } else if (appEnv == AppEnv.dev) {
      return DevEnvironment();
    } else {
      return ProdEnvironment();
    }
  }

  Future<void> map({
    required Future<void> Function() prod,
    required Future<void> Function() dev,
  }) async {
    if (this is ProdEnvironment) {
      await prod();
    } else if (this is DevEnvironment) {
      await dev();
    }
  }
}

// Create a development environment class.

class LocalEnvironment extends Environment {
  LocalEnvironment()
      // : super(name: 'Local', baseUrl: 'http://202.166.170.246:4300/api/');
      : super(name: 'Local', baseUrl: 'http://142.93.236.128:4300/api/');
}

// Create a development environment class.
class DevEnvironment extends Environment {
  DevEnvironment()
      : super(name: 'Dev', baseUrl: 'http://142.93.236.128:4300/api/');
}

// Create a production environment class.
class ProdEnvironment extends Environment {
  ProdEnvironment()
      : super(name: 'Prod', baseUrl: 'http://142.93.236.128:4300/api/');
}
