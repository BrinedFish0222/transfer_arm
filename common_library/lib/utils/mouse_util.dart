import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:plugin_library/plugin_library.dart';
import 'package:native_library/native_library.dart' as nvl;

/// 鼠标工具
class MouseUtil {
  static final _pluginLibraryPlugin = PluginLibrary();

  static Future<void> mouseMove({required int x, required int y}) async {
    // final pluginLibraryPlugin = PluginLibrary();
    // await pluginLibraryPlugin.mouseMove(x: x, y: y);
    nvl.mouseMove(x, y);
  }

  static Future<void> mouseClick({required MouseEvent mouseEvent}) async {
    // await _pluginLibraryPlugin.mouseClick(type: mouseEvent.value);
    nvl.mouseClick(mouseEvent.value);
  }
}
