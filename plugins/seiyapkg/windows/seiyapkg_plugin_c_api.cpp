#include "include/seiyapkg/seiyapkg_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "seiyapkg_plugin.h"

void SeiyapkgPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  seiyapkg::SeiyapkgPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
