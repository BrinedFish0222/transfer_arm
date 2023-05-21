#include "include/plugin_library/plugin_library_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "plugin_library_plugin.h"

void PluginLibraryPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  plugin_library::PluginLibraryPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
