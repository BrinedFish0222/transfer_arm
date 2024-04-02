import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:native_library/native_library.dart' as nvl;

/// 鼠标工具
class MouseUtil {

  static Future<void> mouseMove({required int x, required int y}) async {
    nvl.mouseMove(x, y);
  }

  static Future<void> mouseClick({required MouseEvent mouseEvent}) async {
    nvl.mouseClick(mouseEvent.value);
  }
}
