#ifndef FLUTTER_PLUGIN_SEIYAPKG_PLUGIN_H_
#define FLUTTER_PLUGIN_SEIYAPKG_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace seiyapkg {

class SeiyapkgPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  SeiyapkgPlugin();

  virtual ~SeiyapkgPlugin();

  // Disallow copy and assign.
  SeiyapkgPlugin(const SeiyapkgPlugin&) = delete;
  SeiyapkgPlugin& operator=(const SeiyapkgPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace seiyapkg

#endif  // FLUTTER_PLUGIN_SEIYAPKG_PLUGIN_H_
