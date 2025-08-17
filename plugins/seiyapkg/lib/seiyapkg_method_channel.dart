import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'seiyapkg_platform_interface.dart';

/// An implementation of [SeiyapkgPlatform] that uses method channels.
class MethodChannelSeiyapkg extends SeiyapkgPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('seiyapkg');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
