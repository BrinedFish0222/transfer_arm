import 'plugin_library_platform_interface.dart';

class PluginLibrary {
  Future<String?> getPlatformVersion() {
    return PluginLibraryPlatform.instance.getPlatformVersion();
  }

  Future<void> mouseMove({required int x, required int y}) {
    return PluginLibraryPlatform.instance.mouseMove(x: x, y: y);
  }

  Future<void> mouseClick({required int type}) {
    return PluginLibraryPlatform.instance.mouseClick(type: type);
  }
}
