import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

typedef MessageCallback = void Function(Message<dynamic> message);

@JsonSerializable()
class DefaultMessageProvider implements MessageProvider {
  DefaultMessageProvider({
    this.options,
    this.urlLengthLimit,
    this.defaultRatelimitMaxRequestPerSec,
    this.headerRatelimitLimit,
    this.headerRatelimitNextrequest,
    this.headerRatelimitRemaining,
    this.headerRatelimitReset,
  });

  @override
  void receive(MessageCallback callback) {}

  @override
  dynamic /* Promise<MessageSendResponse> */ send(
    String command, [
    payload,
  ]) {}

  final dynamic options;

  final String? urlLengthLimit;

  final List<String>? defaultRatelimitMaxRequestPerSec;

  final List<String>? headerRatelimitLimit;

  final List<String>? headerRatelimitNextrequest;

  final List<String>? headerRatelimitRemaining;

  final List<String>? headerRatelimitReset;

  factory DefaultMessageProvider.fromJson(Map<String, dynamic> json) =>
      _$DefaultMessageProviderFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DefaultMessageProviderToJson(this);
}

@JsonSerializable()
class Client {
  final Capability capabilities;
  final Performance performance;
  final Skill skill;
  final Speech speech;
  final String version;
  final Voice voice;

  Client({
    required this.capabilities,
    required this.performance,
    required this.skill,
    required this.speech,
    required this.version,
    required this.voice,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable()
class AlexaReadyPayload {
  Client alexa;
  dynamic message;
  AlexaReadyPayload({
    required this.alexa,
    this.message,
  });

  factory AlexaReadyPayload.fromJson(Map<String, dynamic> json) =>
      _$AlexaReadyPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$AlexaReadyPayloadToJson(this);
}

@JsonSerializable()
class AudioData {
  dynamic /* ArrayBuffer */ audioBuffer;
  List<SpeechMark> speechMarks;
  AudioData({
    this.audioBuffer,
    required this.speechMarks,
  });

  factory AudioData.fromJson(Map<String, dynamic> json) =>
      _$AudioDataFromJson(json);
  Map<String, dynamic> toJson() => _$AudioDataToJson(this);
}

@JsonSerializable()
class Microphone {
  final bool supportsPushToTalk;
  final bool supportsWakeWord;

  Microphone(
      {required this.supportsPushToTalk, required this.supportsWakeWord});

  factory Microphone.fromJson(Map<String, dynamic> json) =>
      _$MicrophoneFromJson(json);
  Map<String, dynamic> toJson() => _$MicrophoneToJson(this);
}

@JsonSerializable()
class Capability {
  final Microphone microphone;
  Capability({required this.microphone});

  factory Capability.fromJson(Map<String, dynamic> json) =>
      _$CapabilityFromJson(json);
  Map<String, dynamic> toJson() => _$CapabilityToJson(this);
}

@JsonSerializable()
class CreateClientOptions {
  final MessageProvider? messageProvider;
  final String? version;
  const CreateClientOptions({
    this.messageProvider,
    this.version,
  });

  factory CreateClientOptions.fromJson(Map<String, dynamic> json) =>
      _$CreateClientOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$CreateClientOptionsToJson(this);
}

@JsonSerializable()
class ErrorWithCode {
  final String /* ErrorCode */ code;
  final String message;
  ErrorWithCode({required this.code, required this.message});
  factory ErrorWithCode.fromJson(Map<String, dynamic> json) =>
      _$ErrorWithCodeFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorWithCodeToJson(this);
}

@JsonSerializable()
class FetchAndDemuxError {
  final dynamic /* undefined | { audioBuffer: ArrayBuffer } */ data;
  final String message;
  final num? statusCode;
  FetchAndDemuxError({
    this.data,
    required this.message,
    this.statusCode,
  });

  factory FetchAndDemuxError.fromJson(Map<String, dynamic> json) =>
      _$FetchAndDemuxErrorFromJson(json);
  Map<String, dynamic> toJson() => _$FetchAndDemuxErrorToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class Message<T> {
  final T data;
  final String /* MessageActions */ message;
  Message({required this.data, required this.message});

  factory Message.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$MessageFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$MessageToJson(this, toJsonT);
}

@JsonSerializable()
class MemoryInfo {
  final num availableMemoryInMB;
  MemoryInfo({required this.availableMemoryInMB});

  factory MemoryInfo.fromJson(Map<String, dynamic> json) =>
      _$MemoryInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MemoryInfoToJson(this);
}

@JsonSerializable()
class MemoryInfoError {
  final String message;
  MemoryInfoError({required this.message});

  factory MemoryInfoError.fromJson(Map<String, dynamic> json) =>
      _$MemoryInfoErrorFromJson(json);
  Map<String, dynamic> toJson() => _$MemoryInfoErrorToJson(this);
}

@JsonSerializable()
class MessageProvider {
  void receive(void Function(Message<dynamic> message) callback) {}
  dynamic /* Promise<MessageSendResponse> */ send(
      String command, dynamic payload) {}
  MessageProvider();

  factory MessageProvider.fromJson(Map<String, dynamic> json) =>
      _$MessageProviderFromJson(json);
  Map<String, dynamic> toJson() => _$MessageProviderToJson(this);
}

@JsonSerializable()
class MessageSendResponse {
  final RateLimit rateLimit;
  final String reason;
  final num statusCode;
  MessageSendResponse({
    required this.rateLimit,
    required this.reason,
    required this.statusCode,
  });

  factory MessageSendResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageSendResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageSendResponseToJson(this);
}

@JsonSerializable()
class Performance {
  dynamic /* MemoryInfo | MemoryInfoError */ getMemoryInfo() {}
  Performance();

  factory Performance.fromJson(Map<String, dynamic> json) =>
      _$PerformanceFromJson(json);
  Map<String, dynamic> toJson() => _$PerformanceToJson(this);
}

@JsonSerializable()
class RateLimit {
  final num maxRequestsPerSecond;
  final num remainingRequests;
  final num timeUntilNextRequestMs;
  final num timeUntilResetMs;
  RateLimit({
    required this.maxRequestsPerSecond,
    required this.remainingRequests,
    required this.timeUntilNextRequestMs,
    required this.timeUntilResetMs,
  });

  factory RateLimit.fromJson(Map<String, dynamic> json) =>
      _$RateLimitFromJson(json);
  Map<String, dynamic> toJson() => _$RateLimitToJson(this);
}

@JsonSerializable()
class SpeechMark {
  final String end;
  final String start;
  final String time;
  final String type;
  final String value;
  SpeechMark({
    required this.end,
    required this.start,
    required this.time,
    required this.type,
    required this.value,
  });

  factory SpeechMark.fromJson(Map<String, dynamic> json) =>
      _$SpeechMarkFromJson(json);
  Map<String, dynamic> toJson() => _$SpeechMarkToJson(this);
}

@JsonSerializable()
class Skill {
  Skill onMessage(void Function(dynamic message) callback) {
    return Skill();
  }

  Skill sendMessage(
    dynamic message,
    dynamic /* undefined | ((response: MessageSendResponse) => void) */ callback,
  ) {
    return Skill();
  }

  Skill();

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);
}

@JsonSerializable()
class Speech {
  Speech onStarted(void Function() callback) {
    return Speech();
  }

  Speech onStopped(void Function() callback) {
    return Speech();
  }

  Speech();

  factory Speech.fromJson(Map<String, dynamic> json) => _$SpeechFromJson(json);
  Map<String, dynamic> toJson() => _$SpeechToJson(this);
}

@JsonSerializable()
class SpeechUtils {
  dynamic fetchAndDemuxMP3(String url) {
    return SpeechUtils();
  }

  SpeechUtils();

  factory SpeechUtils.fromJson(Map<String, dynamic> json) =>
      _$SpeechUtilsFromJson(json);
  Map<String, dynamic> toJson() => _$SpeechUtilsToJson(this);
}

@JsonSerializable()
class Voice {
  Speech onMicrophoneClosed(void Function() callback) {
    return Speech();
  }

  Speech onMicrophoneOpened(void Function() callback) {
    return Speech();
  }

  Speech requestMicrophoneOpen([VoiceArgs? config]) {
    return Speech();
  }

  Voice();

  factory Voice.fromJson(Map<String, dynamic> json) => _$VoiceFromJson(json);
  Map<String, dynamic> toJson() => _$VoiceToJson(this);
}

@JsonSerializable()
class VoiceArgs {
  final dynamic /* undefined | void Function() */ onClosed;
  final dynamic /*  undefined | ((error: MicrophoneOpenedError) */ onError;
  final dynamic /* undefined | void Function() */ onOpened;
  VoiceArgs({
    this.onClosed,
    this.onError,
    this.onOpened,
  });

  factory VoiceArgs.fromJson(Map<String, dynamic> json) =>
      _$VoiceArgsFromJson(json);
  Map<String, dynamic> toJson() => _$VoiceArgsToJson(this);
}

@JsonSerializable()
class Utils {
  final SpeechUtils speech;
  Utils({required this.speech});

  factory Utils.fromJson(Map<String, dynamic> json) => _$UtilsFromJson(json);
  Map<String, dynamic> toJson() => _$UtilsToJson(this);
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
