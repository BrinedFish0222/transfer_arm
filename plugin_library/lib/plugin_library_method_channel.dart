import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'plugin_library_platform_interface.dart';

/// An implementation of [PluginLibraryPlatform] that uses method channels.
class MethodChannelPluginLibrary extends PluginLibraryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('plugin_library');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> mouseMove({required int x, required int y}) async {
    return await methodChannel.invokeMethod<void>('mouseMove', [x, y]);
  }

}
