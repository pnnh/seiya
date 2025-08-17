import 'package:flutter_test/flutter_test.dart';
import 'package:seiyapkg/seiyapkg.dart';
import 'package:seiyapkg/seiyapkg_platform_interface.dart';
import 'package:seiyapkg/seiyapkg_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSeiyapkgPlatform
    with MockPlatformInterfaceMixin
    implements SeiyapkgPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SeiyapkgPlatform initialPlatform = SeiyapkgPlatform.instance;

  test('$MethodChannelSeiyapkg is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSeiyapkg>());
  });

  test('getPlatformVersion', () async {
    Seiyapkg seiyapkgPlugin = Seiyapkg();
    MockSeiyapkgPlatform fakePlatform = MockSeiyapkgPlatform();
    SeiyapkgPlatform.instance = fakePlatform;

    expect(await seiyapkgPlugin.getPlatformVersion(), '42');
  });
}
