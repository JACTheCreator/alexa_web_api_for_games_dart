import 'dart:async';
import 'package:flutter_alexa_web_api_for_games/src/flutter_alexa_platform.dart';
import 'package:flutter_alexa_web_api_for_games/src/models/model.dart';

class FlutterAlexa {
  /// Initilizes the
  static Future<bool> init([
    CreateClientOptions options = const CreateClientOptions(),
  ]) async {
    return FlutterAlexaPlatform.instance.init(options);
  }

  /// Gets the current API interface version.
  static Future<String> get alexaVersion async {
    return FlutterAlexaPlatform.instance.alexaVersion;
  }

  /// Fires whenever the memory information changes.
  ///
  /// See [memoryInfo] for more details on the memory information.
  static Stream<MemoryInfo> get onMemoryInfoChanged {
    return FlutterAlexaPlatform.instance.onMemoryInfoChanged;
  }

  /// Get the microphone information.
  ///
  /// The microphone information contains information about if the device
  /// supports push to talk and if the device supports
  /// the wake word.
  static Future<Microphone> get microphoneInfo {
    return FlutterAlexaPlatform.instance.microphoneInfo;
  }

  /// Gets the memory information.
  ///
  /// The memory information contains information about the available
  /// available memory in MB.
  static Future<MemoryInfo> get memoryInfo {
    throw UnimplementedError('get memoryInfo has not been implemented.');
  }

  /// Fires whenever a message is received from your skill.
  static Stream<dynamic> get onMessage {
    return FlutterAlexaPlatform.instance.onMessage;
  }

  /// Sends a message to your skill
  static Future<MessageSendResponse?> sendMessage(dynamic message) {
    return FlutterAlexaPlatform.instance.sendMessage(message);
  }

  static Stream<void> get onSpeechStarted {
    return FlutterAlexaPlatform.instance.onSpeechStarted;
  }

  static Stream<void> get onSpeechStopped {
    return FlutterAlexaPlatform.instance.onSpeechStopped;
  }

  static Stream<void> get onMicrophoneClosed {
    return FlutterAlexaPlatform.instance.onMicrophoneClosed;
  }

  static Stream<void> get onMicrophoneOpened {
    return FlutterAlexaPlatform.instance.onMicrophoneClosed;
  }

  static Future<void> get requestMicrophoneOpen {
    return FlutterAlexaPlatform.instance.requestMicrophoneOpen;
  }
}
