import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'seiyapkg_method_channel.dart';

abstract class SeiyapkgPlatform extends PlatformInterface {
  /// Constructs a SeiyapkgPlatform.
  SeiyapkgPlatform() : super(token: _token);

  static final Object _token = Object();

  static SeiyapkgPlatform _instance = MethodChannelSeiyapkg();

  /// The default instance of [SeiyapkgPlatform] to use.
  ///
  /// Defaults to [MethodChannelSeiyapkg].
  static SeiyapkgPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SeiyapkgPlatform] when
  /// they register themselves.
  static set instance(SeiyapkgPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
