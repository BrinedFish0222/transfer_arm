//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <plugin_library/plugin_library_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) plugin_library_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PluginLibraryPlugin");
  plugin_library_plugin_register_with_registrar(plugin_library_registrar);
}
