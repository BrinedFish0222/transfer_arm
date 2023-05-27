import 'package:logger/logger.dart';

class LogUtil  {

  static final LogUtil _instance = LogUtil._internal();

  var logger = Logger();
  static const String _logPre = '#### 机械手日志：';

  // 私有的命名构造函数
  LogUtil._internal();

  factory LogUtil.getInstance() {
    return _instance;
  }

  static void error(String msg) {
    LogUtil.getInstance().logger.e("$_logPre$msg");
  }

  static void info(String msg) {
    LogUtil.getInstance().logger.i("$_logPre$msg");
  }

  static void warning (String msg) {
    LogUtil.getInstance().logger.w("$_logPre$msg");
  }

  static void debug (String msg) {
    LogUtil.getInstance().logger.d("$_logPre$msg");
  }

}
