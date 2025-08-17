//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <seiyapkg/seiyapkg_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) seiyapkg_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SeiyapkgPlugin");
  seiyapkg_plugin_register_with_registrar(seiyapkg_registrar);
}
