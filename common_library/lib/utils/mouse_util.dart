

import 'package:plugin_library/plugin_library.dart';

/// 鼠标工具
class MouseUtil {
  static void mouseMove({required int x, required int y, int shake = 0}) {
    final pluginLibraryPlugin = PluginLibrary();
    pluginLibraryPlugin.mouseMove(x: x, y: y);
  }
}
