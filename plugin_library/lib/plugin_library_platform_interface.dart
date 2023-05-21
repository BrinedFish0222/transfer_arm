import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'plugin_library_method_channel.dart';

abstract class PluginLibraryPlatform extends PlatformInterface {
  /// Constructs a PluginLibraryPlatform.
  PluginLibraryPlatform() : super(token: _token);

  static final Object _token = Object();

  static PluginLibraryPlatform _instance = MethodChannelPluginLibrary();

  /// The default instance of [PluginLibraryPlatform] to use.
  ///
  /// Defaults to [MethodChannelPluginLibrary].
  static PluginLibraryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PluginLibraryPlatform] when
  /// they register themselves.
  static set instance(PluginLibraryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

   Future<void> mouseMove({required int x, required int y}) {
    throw UnimplementedError('mouseMove() has not been implemented.');
  }
}
