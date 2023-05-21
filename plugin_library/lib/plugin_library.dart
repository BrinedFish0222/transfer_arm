
import 'plugin_library_platform_interface.dart';

class PluginLibrary {
  Future<String?> getPlatformVersion() {
    return PluginLibraryPlatform.instance.getPlatformVersion();
  }
}
