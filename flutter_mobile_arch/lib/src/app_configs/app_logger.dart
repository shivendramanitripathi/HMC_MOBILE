import 'package:logger/logger.dart';

class AppLogger {
  final Logger _logger;

  AppLogger()
      : _logger = Logger(
          filter: ProductionFilter(),
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
          ),
          level: Level.debug,
        );

  void logDebug(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void logInfo(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void logWarning(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void logError(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  // void logVerbose(String message, {dynamic error, StackTrace? stackTrace}) {
  //   _logger.v(message, error: error, stackTrace: stackTrace);
  // }

  void logCustom(String message, Level level,
      {dynamic error, StackTrace? stackTrace}) {
    _logger.log(level, message, error: error, stackTrace: stackTrace);
  }
}
