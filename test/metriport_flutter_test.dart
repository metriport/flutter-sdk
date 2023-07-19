import 'package:flutter_test/flutter_test.dart';
import 'package:metriport_flutter/metriport_flutter.dart';
import 'package:metriport_flutter/metriport_flutter_platform_interface.dart';
import 'package:metriport_flutter/metriport_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMetriportFlutterPlatform
    with MockPlatformInterfaceMixin
    implements MetriportFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MetriportFlutterPlatform initialPlatform = MetriportFlutterPlatform.instance;

  test('$MethodChannelMetriportFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMetriportFlutter>());
  });

  test('getPlatformVersion', () async {
    MetriportFlutter metriportFlutterPlugin = MetriportFlutter();
    MockMetriportFlutterPlatform fakePlatform = MockMetriportFlutterPlatform();
    MetriportFlutterPlatform.instance = fakePlatform;

    expect(await metriportFlutterPlugin.getPlatformVersion(), '42');
  });
}
