

import 'package:common_library/utils/constants/mouse_event.dart';
import 'package:plugin_library/plugin_library.dart';

/// 鼠标工具
class MouseUtil {
  static final _pluginLibraryPlugin = PluginLibrary();

  static void mouseMove({required int x, required int y, int shake = 0}) {
    final pluginLibraryPlugin = PluginLibrary();
    pluginLibraryPlugin.mouseMove(x: x, y: y);
  }

  static void mouseClick({required MouseEvent mouseEvent}) {
    _pluginLibraryPlugin.mouseClick(type: mouseEvent.value);
  }

}
