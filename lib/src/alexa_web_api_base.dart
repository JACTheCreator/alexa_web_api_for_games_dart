import 'dart:html';
import 'dart:js_util';
import 'package:js/js.dart';

typedef MessageCallback = void Function(Message<dynamic> message);

@anonymous
@JS('Alexa.DefaultMessageProvider')
abstract class DefaultMessageProvider implements MessageProvider {
  external factory DefaultMessageProvider({
    dynamic /* undefined | { apiUrl?: undefined | string; dispatchFunc?: undefined | string; urlLengthLimit?: undefined | number } */ options,
    String? urlLengthLimit,
  });

  @JS('Alexa.DefaultMessageProvider.receive')
  @override
  void receive(MessageCallback callback);

  @JS('Alexa.DefaultMessageProvider.send')
  @override
  dynamic /* Promise<MessageSendResponse> */ send(
    String command, [
    payload,
  ]);

  @JS('Alexa.DefaultMessageProvider.DEFAULT_RATELIMIT_MAX_REQUEST_PER_SEC')
  external List<String> get defaultRatelimitMaxRequestPerSec;

  @JS('Alexa.DefaultMessageProvider.HEADER_RATELIMIT_LIMIT')
  external List<String> get headerRatelimitLimit;

  @JS('Alexa.DefaultMessageProvider.HEADER_RATELIMIT_NEXTREQUEST')
  external List<String> get headerRatelimitNextrequest;

  @JS('Alexa.DefaultMessageProvider.HEADER_RATELIMIT_REMAINING')
  external List<String> get headerRatelimitRemaining;

  @JS('Alexa.DefaultMessageProvider.HEADER_RATELIMIT_RESET')
  external List<String> get headerRatelimitReset;
}

@JS('Alexa.create')
external AlexaReadyPayload /* AlexaReadyPayload | ErrorWithCode */
    _create(CreateClientOptions option);

@JS('Alexa.utils')
external Utils _utils;

class Alexa {
  static Future<AlexaReadyPayload /* AlexaReadyPayload | ErrorWithCode */ >
      create(CreateClientOptions option) {
    return promiseToFuture(_create(option));
  }

  static Utils get utils => _utils;
}

@anonymous
@JS('Alexa.Client')
abstract class Client {
  external Capability capabilities;
  external Performance performance;
  external Skill skill;
  external Speech speech;
  external String version;
  external Voice voice;
  external factory Client({
    Capability capabilities,
    Performance performance,
    Skill skill,
    Speech speech,
    String version,
    Voice voice,
  });
}

@anonymous
@JS('Alexa.AlexaReadyPayload')
abstract class AlexaReadyPayload {
  external Client alexa;
  external dynamic message;
  external factory AlexaReadyPayload({
    Client alexa,
    dynamic message,
  });
}

@anonymous
@JS('Alexa.AudioData')
abstract class AudioData {
  external dynamic /* ArrayBuffer */ audioBuffer;
  external List<SpeechMark> speechMarks;
  external factory AudioData({
    dynamic /* ArrayBuffer */ audioBuffer,
    List<SpeechMark> speechMarks,
  });
}

// abstract class CapabilityOptions {
//   bool get supportsPushToTalk;
//   bool get supportsWakeWord;
// }

@anonymous
@JS('Alexa.Capability')
abstract class Capability {
  external dynamic microphone;
  external factory Capability({dynamic microphone});
}

@anonymous
@JS('Alexa.CreateClientOptions')
abstract class CreateClientOptions {
  external MessageProvider? messageProvider;
  external String? version;
  external factory CreateClientOptions({
    MessageProvider? messageProvider,
    String? version,
  });
}

@anonymous
@JS('Alexa.ErrorWithCode')
class ErrorWithCode {
  external String /* ErrorCode */ code;
  external String message;
  external factory ErrorWithCode({String code, String message});
}

@anonymous
@JS('Alexa.FetchAndDemuxError')
abstract class FetchAndDemuxError {
  external dynamic /* undefined | { audioBuffer: ArrayBuffer } */ data;
  external String message;
  external num? statusCode;
  external factory FetchAndDemuxError({
    dynamic /* undefined | { audioBuffer: ArrayBuffer } */ data,
    String message,
    num? statusCode,
  });
}

@anonymous
@JS('Alexa.Message')
abstract class Message<T> {
  external T data;
  external String /* MessageActions */ message;
  external factory Message({T data, String /* MessageActions */ message});
}

@anonymous
@JS('Alexa.MemoryInfo')
abstract class MemoryInfo {
  external num availableMemoryInMB;
  external factory MemoryInfo({num availableMemoryInMB});
}

@anonymous
@JS('Alexa.MemoryInfoError')
abstract class MemoryInfoError {
  external String message;
  external factory MemoryInfoError({String message});
}

@anonymous
@JS('Alexa.MessageProvider')
abstract class MessageProvider {
  external void receive(void Function(Message<dynamic> message) callback);
  external dynamic /* Promise<MessageSendResponse> */ send(
      String command, dynamic payload);
  external factory MessageProvider();
}

@anonymous
@JS('Alexa.MessageSendResponse')
abstract class MessageSendResponse {
  external RateLimit rateLimit;
  external String reason;
  external num statusCode;
  external factory MessageSendResponse({
    RateLimit rateLimit,
    String reason,
    num statusCode,
  });
}

@anonymous
@JS('Alexa.Performance')
abstract class Performance {
  external dynamic /* MemoryInfo | MemoryInfoError */ getMemoryInfo();
  external factory Performance();
}

@anonymous
@JS('Alexa.RateLimit')
abstract class RateLimit {
  external num maxRequestsPerSecond;
  external num remainingRequests;
  external num timeUntilNextRequestMs;
  external num timeUntilResetMs;
  external factory RateLimit({
    num maxRequestsPerSecond,
    num remainingRequests,
    num timeUntilNextRequestMs,
    num timeUntilResetMs,
  });
}

@anonymous
@JS('Alexa.SpeechMark')
abstract class SpeechMark {
  external String end;
  external String start;
  external String time;
  external String type;
  external String value;
  external factory SpeechMark({
    String end,
    String start,
    String time,
    String type,
    String value,
  });
}

@anonymous
@JS('Alexa.Skill')
abstract class Skill {
  Skill onMessage(void Function(dynamic message) callback);
  Skill sendMessage(
    dynamic message,
    dynamic /* undefined | ((response: MessageSendResponse) => void) */ callback,
  );
  external factory Skill();
}

@anonymous
@JS('Alexa.Speech')
abstract class Speech {
  external Speech onStarted(void Function() callback);
  external Speech onStopped(void Function() callback);
  external factory Speech();
}

@anonymous
@JS('Alexa.Speech')
abstract class SpeechUtils {
  external dynamic /* AudioData | FetchAndDemuxError */
      fetchAndDemuxMP3(String url);
  external factory SpeechUtils();
}

@anonymous
@JS('Alexa.Voice')
abstract class Voice {
  external Speech onMicrophoneClosed(void Function() callback);
  external Speech onMicrophoneOpened(void Function() callback);
  external Speech requestMicrophoneOpen([VoiceArgs? config]);
  external factory Voice();
}

@anonymous
@JS('Alexa.VoiceArgs')
abstract class VoiceArgs {
  external dynamic /* undefined | void Function() */ onClosed;
  external dynamic /*  undefined | ((error: MicrophoneOpenedError) */ onError;
  external dynamic /* undefined | void Function() */ onOpened;
  external factory VoiceArgs({
    dynamic /* undefined | void Function() */ onClosed,
    dynamic /*  undefined | ((error: MicrophoneOpenedError) */ onError,
    dynamic /* undefined | void Function() */ onOpened,
  });
}

@anonymous
@JS('Alexa.Utils')
abstract class Utils {
  external SpeechUtils speech;
  external factory Utils({SpeechUtils speech});
}

class MessageActions {
  static const String alexaHtmlReady = 'alexa-html-ready';
  static const String messageToHtml = 'message-to-html';
  static const String ttsStarted = 'tts-started';
  static const String ttsStopped = 'tts-stopped';
  static const String micEvent = 'mic-event';
  static const String micRequestedEvent = 'mic-requested-event';
  static const String memoryAvailable = 'memory-available';
}

class MicrophoneOpenedError {
  static const String microphoneAlreadyOpen = 'microphone-already-open';
  static const String requestOpenUnsupported = 'request-open-unsupported';
  static const String tooManyRequests = 'too-many-requests';
  static const String unknown = 'unknown';
}

class ErrorCode {
  static const String noSuchVersion = 'no-such-version';
  static const String unauthorizedAccess = 'unauthorized-access';
  static const String tooManyRequests = 'too-many-requests';
  static const String unknown = 'unknown';
}

Stream<T> promiseToStream<T, E extends Object>(dynamic jsPromise,
    [Duration? interval]) async* {
  interval = interval ?? Duration(seconds: 1);

  while (true) {
    T? value;
    E? error;
    await promiseToFuture(jsPromise()).then((jsValue) {
      value = jsValue;
    }).onError(
      (E? err, stackTrace) {
        error = err;
      },
    );
    if (error != null) {
      yield* Stream<T>.error(error!.toString());
    } else {
      yield value!;
    }
    await Future.delayed(interval);
  }
}
