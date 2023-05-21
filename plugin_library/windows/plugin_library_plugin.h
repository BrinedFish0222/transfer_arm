#ifndef FLUTTER_PLUGIN_PLUGIN_LIBRARY_PLUGIN_H_
#define FLUTTER_PLUGIN_PLUGIN_LIBRARY_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace plugin_library {

class PluginLibraryPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PluginLibraryPlugin();

  virtual ~PluginLibraryPlugin();

  // Disallow copy and assign.
  PluginLibraryPlugin(const PluginLibraryPlugin&) = delete;
  PluginLibraryPlugin& operator=(const PluginLibraryPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace plugin_library

#endif  // FLUTTER_PLUGIN_PLUGIN_LIBRARY_PLUGIN_H_
