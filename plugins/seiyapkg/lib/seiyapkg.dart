import './bindings.dart';
import 'seiyapkg_platform_interface.dart';

class Seiyapkg {
  Future<String?> getPlatformVersion() {
    return SeiyapkgPlatform.instance.getPlatformVersion();
  }

  Future<int> calcSum(int a, int b) async {
    return FFIBindings.nativeAdd(a, b);
  }

  Future convertSvgToPng(String svgFilePath, String destFilePath) async {
    return FFIBindings.convertSvgToPng(svgFilePath, destFilePath);
  }
}
