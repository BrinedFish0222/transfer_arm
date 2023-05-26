import 'package:logger/logger.dart';

class LogUtil {
  static var logger = Logger();

  static const String _logPre = '#### 机械手日志 ####';

  static void error(String msg) {
    logger.e("$_logPre\n$msg");
  }

  static void info(String msg) {
    logger.i("$_logPre\n$msg");
  }

  static void warning(String msg) {
    logger.w("$_logPre\n$msg");
  }

  static void debug(String msg) {
    logger.d("$_logPre\n$msg");
  }
}
