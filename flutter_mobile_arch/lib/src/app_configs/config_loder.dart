import '../services/api_routes.dart';

enum Environment { test, production }

class ConfigLoader {
  static Environment currentEnvironment = Environment.production;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.test:
        return TestConfig.baseUrl;
      case Environment.production:
      default:
        return ProdConfig.baseUrl;
    }
  }
}
