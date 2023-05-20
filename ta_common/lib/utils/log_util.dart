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

  void error(String msg) {
    logger.e("$_logPre$msg");
  }

  void info(String msg) {
    logger.i("$_logPre$msg");
  }

  void warning (String msg) {
    logger.w("$_logPre$msg");
  }

  void debug (String msg) {
    logger.d("$_logPre$msg");
  }

}
