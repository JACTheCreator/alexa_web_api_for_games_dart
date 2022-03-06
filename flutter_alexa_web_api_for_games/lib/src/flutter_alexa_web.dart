import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'dart:js_util';

import 'package:alexa_web_api/alexa_web_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alexa_web_api_for_games/src/exceptions/alexa_not_initialized.exception.dart';
import 'package:flutter_alexa_web_api_for_games/src/flutter_alexa_platform.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'exceptions/alexa_initialization.exception.dart';
import 'models/model.dart' as model;

/// A web implementation of the FlutterAlexaWebApiForGames plugin.
class FlutterAlexaWeb extends FlutterAlexaPlatform {
  MethodChannel methodChannel =
      const MethodChannel('jacthecreator/flutter_alexa');

  Client? _alexa;
  dynamic _message;

  StreamController<void>? _speechStartedStreamController;
  StreamController<void>? _speechStoppedStreamController;
  StreamController? _messageStreamController;
  StreamController<void>? _microphoneClosedStreamController;
  StreamController<void>? _microphoneOpenedStreamController;

  late Stream _messageChange;
  late Stream _speechStartedChange;
  late Stream _speechStoppedChange;
  late Stream _microphoneClosedChange;
  late Stream _microphoneOpenedChange;

  static void registerWith(Registrar registrar) {
    FlutterAlexaPlatform.instance = FlutterAlexaWeb();
  }

  @override
  Future<bool> init([
    model.CreateClientOptions options = const model.CreateClientOptions(),
  ]) async {
    try {
      MessageProvider? messageProvider = _getMessageProvider(
        options.messageProvider,
      );
      var payload = await Alexa.create(
        CreateClientOptions(
          version: options.version,
          messageProvider: messageProvider,
        ),
      );
      _alexa = payload.alexa;
      _message = payload.message;
      return true;
    } on ErrorWithCode catch (e) {
      if (e.code == ErrorCode.unknown) {
        return false;
      }
      throw AlexaInitializationException(e.code, e.message);
    }
  }

  @override
  Future<String> get alexaVersion {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    return Future.value(_alexa!.version);
  }

  @override
  Stream<model.MemoryInfo> get onMemoryInfoChanged async* {
    Duration interval = const Duration(seconds: 1);
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }

    while (true) {
      model.MemoryInfo? value;
      model.MemoryInfoError? error;
      await promiseToFuture(_alexa!.performance.getMemoryInfo()).then((info) {
        MemoryInfo memoryInfo = info;
        value = model.MemoryInfo(
          availableMemoryInMB: memoryInfo.availableMemoryInMB,
        );
      }).onError(
        (MemoryInfoError err, stackTrace) {
          error = model.MemoryInfoError(message: err.message);
        },
      );
      if (error != null) {
        yield* Stream.error(error!.toString());
      } else {
        yield value!;
      }
      await Future.delayed(interval);
    }
  }

  @override
  Future<model.MemoryInfo> get memoryInfo async {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    var memoryInfo = await promiseToFuture(_alexa!.performance.getMemoryInfo());
    Map<String, dynamic> json = jsonDecode(memoryInfo.toString());
    return model.MemoryInfo.fromJson(json);
  }

  @override
  Future<model.Microphone> get microphoneInfo {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    return Future.value(
      model.Microphone(
        supportsPushToTalk: _alexa!.capabilities.microphone.supportsPushToTalk,
        supportsWakeWord: _alexa!.capabilities.microphone.supportsWakeWord,
      ),
    );
  }

  @override
  Stream<dynamic> get onMessage {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    if (_messageStreamController == null) {
      _messageStreamController = StreamController();
      _alexa!.skill.onMessage(
        allowInterop(
          (message) {
            _messageStreamController!.add(message);
          },
        ),
      );
      _messageChange = _messageStreamController!.stream.asBroadcastStream();
    }
    return _messageChange;
  }

  @override
  Future<model.MessageSendResponse?> sendMessage(dynamic message) async {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    model.MessageSendResponse? _response;

    _alexa!.skill.sendMessage(
      message,
      allowInterop(
        (MessageSendResponse response) {
          _response = model.MessageSendResponse(
            rateLimit: model.RateLimit(
              maxRequestsPerSecond: response.rateLimit.maxRequestsPerSecond,
              remainingRequests: response.rateLimit.remainingRequests,
              timeUntilNextRequestMs: response.rateLimit.timeUntilNextRequestMs,
              timeUntilResetMs: response.rateLimit.timeUntilResetMs,
            ),
            reason: response.reason,
            statusCode: response.statusCode,
          );
        },
      ),
    );

    return _response;
  }

  @override
  Stream<void> get onSpeechStarted {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    if (_speechStartedStreamController == null) {
      _speechStartedStreamController = StreamController();
      _alexa!.speech.onStopped(
        allowInterop(
          () {
            _speechStartedStreamController!.add(null);
          },
        ),
      );
      _speechStartedChange =
          _speechStartedStreamController!.stream.asBroadcastStream();
    }

    return _speechStartedChange;
  }

  @override
  Stream<void> get onSpeechStopped {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    if (_speechStoppedStreamController == null) {
      _speechStoppedStreamController = StreamController();
      _alexa!.speech.onStopped(
        allowInterop(
          () {
            _speechStoppedStreamController!.add(null);
          },
        ),
      );
      _speechStoppedChange =
          _speechStoppedStreamController!.stream.asBroadcastStream();
    }

    return _speechStoppedChange;
  }

  @override
  Stream<void> get onMicrophoneClosed {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    if (_microphoneClosedStreamController == null) {
      _microphoneClosedStreamController = StreamController();
      _alexa!.voice.onMicrophoneClosed(
        allowInterop(
          () {
            _microphoneClosedStreamController!.add(null);
          },
        ),
      );
      _microphoneClosedChange =
          _microphoneClosedStreamController!.stream.asBroadcastStream();
    }

    return _microphoneClosedChange;
  }

  @override
  Stream<void> get onMicrophoneOpened {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    if (_microphoneOpenedStreamController == null) {
      _microphoneOpenedStreamController = StreamController();
      _alexa!.voice.onMicrophoneOpened(
        allowInterop(
          () {
            _microphoneOpenedStreamController!.add(null);
          },
        ),
      );
      _microphoneOpenedChange =
          _microphoneOpenedStreamController!.stream.asBroadcastStream();
    }

    return _microphoneOpenedChange;
  }

  @override
  Future<void> get requestMicrophoneOpen {
    if (_alexa == null) {
      throw AlexaNotInitializedException();
    }
    _alexa!.voice.requestMicrophoneOpen();
    return Future.value();
  }

  MessageProvider? _getMessageProvider(model.MessageProvider? messageProvider) {
    if (messageProvider == null) {
      return null;
    }
    if (messageProvider is model.DefaultMessageProvider) {
      return DefaultMessageProvider(
        options: messageProvider.options,
        urlLengthLimit: messageProvider.urlLengthLimit,
      );
    }

    return MessageProvider();
  }
}
