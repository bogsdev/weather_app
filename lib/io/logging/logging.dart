import 'package:logging/logging.dart';

class Log {
  Logger _logger;

  Log(String identity) {
    _logger = Logger(identity);
  }

  void print(String message) {
    _logger.info(message);
  }

  void error(String message, {dynamic e, StackTrace s}) {
    _logger.severe(message, e, s);
  }
}

void setUpLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print(
        '[${rec.loggerName}] |${rec.level.name.substring(0, 2)}| (${rec.time.toIso8601String()}): ${rec.message}');
    if (rec.error != null || rec.stackTrace != null) {
      print(
          'ERROR START (${rec.time}) ========================================');
      if (rec.error != null) {
        print('${rec.time}: ${rec.message}');
      }
      if (rec.stackTrace != null) {
        print('${rec.time}: ${rec.stackTrace}');
      }
      print(
          'ERROR END (${rec.time}) ========================================\n');
    }
  });
}

void quickLog(String identity, String message, {dynamic e, StackTrace s}) {
  Log log = Log(identity);
  if (e != null || s != null) {
    log.error(message, e: e, s: s);
  } else {
    log.print(message);
  }
}
