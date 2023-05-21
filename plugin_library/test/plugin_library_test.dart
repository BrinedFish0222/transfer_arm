// import 'package:flutter_test/flutter_test.dart';
// import 'package:plugin_library/plugin_library.dart';
// import 'package:plugin_library/plugin_library_platform_interface.dart';
// import 'package:plugin_library/plugin_library_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockPluginLibraryPlatform
//     with MockPlatformInterfaceMixin
//     implements PluginLibraryPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final PluginLibraryPlatform initialPlatform = PluginLibraryPlatform.instance;

//   test('$MethodChannelPluginLibrary is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelPluginLibrary>());
//   });

//   test('getPlatformVersion', () async {
//     PluginLibrary pluginLibraryPlugin = PluginLibrary();
//     MockPluginLibraryPlatform fakePlatform = MockPluginLibraryPlatform();
//     PluginLibraryPlatform.instance = fakePlatform;

//     expect(await pluginLibraryPlugin.getPlatformVersion(), '42');
//   });
// }
