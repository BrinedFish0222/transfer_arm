
import 'dart:math';

/// 随机工具类
class RandomUtil {

  static int nextInt(int start, int end) {
    int randomInt = Random().nextInt(end - start + 1) + start;
    return randomInt;
  }


  /// 是否是正号。
  /// 返回值：true 正。false 负。
  static bool isPlusSign() {
    return Random().nextInt(2) == 0 ? false : true;
  }
}