import 'package:flutter/foundation.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:logging/logging.dart' as logging;
import 'package:spotx/utils/analytics/i_analytics.dart';
import 'package:logger/logger.dart' as pretty_logger;

final log = logging.Logger('AppLogger');

final logger = pretty_logger.Logger(
  printer: pretty_logger.PrettyPrinter(),
);
setupLogger() {
  if(kReleaseMode){
    if (kReleaseMode) {
      // this should skip printing in release mode
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
    IAnalytics analytics = Injector().get<IAnalytics>();
    logging.Logger.root.level = logging.Level.SEVERE;
    logging.Logger.root.onRecord.listen((record) {
      analytics.logEvent(
          name: record.level.name,
          parameters: {
            "message" : record.message,
            "error" : record.error,
            "stackTrace" : record.stackTrace,
            "time" : record.time
          });
    });
  } else {
    logging.Logger.root.level = logging.Level.ALL;
    logging.Logger.root.onRecord.listen((record) {
      if(record.level == logging.Level.FINE ||
      record.level == logging.Level.FINER ||
      record.level == logging.Level.FINEST
      ) {
        logger.d(record.message, record.error, record.stackTrace);
      } else if(record.level == logging.Level.INFO){
        logger.i(record.message, record.error, record.stackTrace);
      } else if(record.level == logging.Level.SEVERE){
        logger.e(record.message, record.error, record.stackTrace);
      } else if(record.level == logging.Level.SHOUT){
        logger.wtf(record.message, record.error, record.stackTrace);
      }
    });
  }
}