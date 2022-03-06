import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_alexa_web_api_for_games/flutter_alexa_web_api_for_games.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('flutter_alexa_web_api_for_games');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await FlutterAlexa.platformVersion, '42');
  });
}
