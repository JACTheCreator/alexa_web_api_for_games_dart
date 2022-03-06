import 'package:flutter_alexa_web_api_for_games/src/models/model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FlutterAlexaPlatform extends PlatformInterface {
  /// Constructs a ConnectivityPlatform.
  FlutterAlexaPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAlexaPlatform _instance = FlutterAlexaPlatform();

  /// The default instance of [FlutterAlexaPlatform] to use.
  ///
  /// Defaults to [FlutterAlexaPlatform].
  static FlutterAlexaPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterAlexaPlatform] when they register themselves.
  static set instance(FlutterAlexaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Checks the connection status of the device.
  Future<bool> init([
    CreateClientOptions options = const CreateClientOptions(),
  ]) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<String> get alexaVersion {
    throw UnimplementedError('get alexaVersion has not been implemented.');
  }

  Stream<MemoryInfo> get onMemoryInfoChanged {
    throw UnimplementedError('get alexaVersion has not been implemented.');
  }

  Future<Microphone> get microphoneInfo {
    throw UnimplementedError('get microphoneInfo has not been implemented.');
  }

  Future<MemoryInfo> get memoryInfo {
    throw UnimplementedError('get memoryInfo has not been implemented.');
  }

  Stream<dynamic> get onMessage {
    throw UnimplementedError('get onMessage has not been implemented.');
  }

  Future<MessageSendResponse?> sendMessage(dynamic message) {
    throw UnimplementedError('get onMessage has not been implemented.');
  }

  Stream<void> get onSpeechStarted {
    throw UnimplementedError('get onSpeechStarted has not been implemented.');
  }

  Stream<void> get onSpeechStopped {
    throw UnimplementedError('get onSpeechStopped has not been implemented.');
  }

  Stream<void> get onMicrophoneClosed {
    throw UnimplementedError(
      'get onMicrophoneClosed has not been implemented.',
    );
  }

  Stream<void> get onMicrophoneOpened {
    throw UnimplementedError(
      'get onMicrophoneOpened has not been implemented.',
    );
  }

  Future<void> get requestMicrophoneOpen {
    throw UnimplementedError(
      'get requestMicrophoneOpen has not been implemented.',
    );
  }
}
