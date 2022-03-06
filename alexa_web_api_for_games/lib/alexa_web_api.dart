@JS('Alexa')
library alexa_web_api;

import 'dart:html';
import 'package:js/js.dart';

/// Function to be called whenever a message is received from the device.
/// Function should take Message as a parameter to receive the contents of the message.
typedef MessageCallback = void Function(Message<dynamic> message);

typedef OnMessageCallback = void Function(dynamic message);

/// Function to call on request error.
typedef MicrophoneOpenedErrorCallback = void Function(String error);

typedef MessageSendResponseCallback = void Function(
  MessageSendResponse response,
);

/// Implements the MessageProvider for WebView based devices that allow url interception
/// and direct message evaluation (script injection).
///
/// Messages are passed to device via HTTP GET and JSON encoded URLs.
///
/// Messages are passed from device to browser from script evaluation via a known function
/// which defaults to window.__dispatchMessage.
@anonymous
@JS()
abstract class DefaultMessageProvider implements MessageProvider {
  /// Initializes the message provider with the given options.
  /// In most cases, users should not have to supply their own options for these values.
  external factory DefaultMessageProvider({
    dynamic /* undefined | { apiUrl?: undefined | string; dispatchFunc?: undefined | string; urlLengthLimit?: undefined | number } */ options,
    String? urlLengthLimit,
  });

  @override
  set receive(MessageCallback callback);

  @override
  dynamic /* Promise<MessageSendResponse> */ send(
    String command, [
    payload,
  ]);

  @JS('DEFAULT_RATELIMIT_MAX_REQUEST_PER_SEC')
  external List<String> get defaultRatelimitMaxRequestPerSec;

  @JS('HEADER_RATELIMIT_LIMIT')
  external List<String> get headerRatelimitLimit;

  @JS('HEADER_RATELIMIT_NEXTREQUEST')
  external List<String> get headerRatelimitNextrequest;

  @JS('HEADER_RATELIMIT_REMAINING')
  external List<String> get headerRatelimitRemaining;

  @JS('HEADER_RATELIMIT_RESET')
  external List<String> get headerRatelimitReset;
}

@JS('create')
external AlexaReadyPayload _create(CreateClientOptions option);

@JS('utils')
external Utils _utils;

class Alexa {
  /// Asynchronously creates an Alexa Client.
  ///
  /// Returns a Future which is fulfilled with [AlexaReadyPayload] or rejected with an [ErrorWithCode].
  ///
  /// Takes an optional [option] where you can override the option defaults.
  ///
  /// If a version isn't provided it will default to the latest API. This can only be called once per page.
  static Future<AlexaReadyPayload> create(CreateClientOptions option) {
    return promiseToFuture<AlexaReadyPayload>(_create(option));
  }

  /// Collection of utility objects and functions that aid in development.
  static Utils get utils => _utils;
}

/// The Alexa Client object provides interfaces to communicate with your skill and
/// with the device.
@anonymous
@JS()
abstract class Client {
  /// The device capabilities
  external Capability capabilities;

  /// Provides the interface to get the available memory on the device.
  ///
  /// Use the performance interface to get the available memory on the device.
  /// This interface is useful in development for optimizing assets and debugging across device
  /// types.
  ///
  /// Important: Don't use the performance interface in production because the
  /// invocation can negatively affect device performance.
  external Performance performance;

  /// Provides the interfaces to communicate with your skill.
  ///
  /// For details, see [Skill.onMessage] and [Skill.sendMessage].
  external Skill skill;

  /// Provides the interfaces to receive Alexa speech events.
  /// For details, see  [Speech].
  external Speech speech;

  /// Version of the Alexa client.
  /// If you don't specify a version, the latest version is used.
  external String version;

  /// Provides the interfaces to open the microphone on the device to
  /// receive user utteranc
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

/// The Future resolve result from a successful create invocation.
@anonymous
@JS()
abstract class AlexaReadyPayload {
  /// The initialized and ready Alexa client
  external Client alexa;

  /// Start up information provided by the skill.
  // The JSON value from the data property of the Start directive.
  external dynamic message;

  external factory AlexaReadyPayload({
    Client alexa,
    dynamic message,
  });
}

/// AudioData result of fetching and demuxing an Alexa transformed speech mp3
@anonymous
@JS()
abstract class AudioData {
  /// The demuxed mp3 audio ArrayBuffer (no embedded speech marks)
  external dynamic /* ArrayBuffer */ audioBuffer;

  /// The collection of speech marks from the mp3
  external List<SpeechMark> speechMarks;

  external factory AudioData({
    dynamic /* ArrayBuffer */ audioBuffer,
    List<SpeechMark> speechMarks,
  });
}

/// The Capability object provides information about the device.
@anonymous
@JS()
abstract class Capability {
  /// Capabilities of the microphone on the device.
  external Microphone microphone;
  external factory Capability({dynamic microphone});
}

/// Construction options for the HTML SDK Client object.
@anonymous
@JS()
abstract class CreateClientOptions {
  /// Used for simulation or testing.
  external MessageProvider? messageProvider;

  /// Version of the Alexa client.
  /// Requesting an invalid version is rejected with [ErrorCode.noSuchVersion] error code
  /// from [ErrorWithCode].
  external String? version;

  external factory CreateClientOptions({
    MessageProvider? messageProvider,
    String? version,
  });
}

/// [ErrorWithCode] is the [Alexa.create] Promise reject result.
@anonymous
@JS()
class ErrorWithCode {
  /// Code indicating the cause of failure.
  external String /* ErrorCode */ code;

  /// Descriptive string error message.
  external String message;

  external factory ErrorWithCode({
    String code,
    String message,
  });
}

/// This error indicates an MP3 could not be retrieved from Alexa.
@anonymous
@JS()
abstract class FetchAndDemuxError {
  /// The [AudioData] the demuxer was able to extract. If this property is present it
  /// will contain a playable audio buffer.
  external dynamic /* undefined | { audioBuffer: ArrayBuffer } */ data;

  /// Descriptive string error message.
  external String message;

  /// The specific HTTP error code when encountered trying to download the file.
  /// In the event of a client timeout, this would be undefined.
  external num? statusCode;

  external factory FetchAndDemuxError({
    dynamic /* undefined | { audioBuffer: ArrayBuffer } */ data,
    String message,
    num? statusCode,
  });
}

/// [MemoryInfo] is the [Performance.getMemoryInfo] Promise resolve result.
@anonymous
@JS()
abstract class MemoryInfo {
  /// The available memory in MB
  external num availableMemoryInMB;

  external factory MemoryInfo({num availableMemoryInMB});
}

/// [MemoryInfoError] is the [Performance.getMemoryInfo] Promise reject result.
@anonymous
@JS()
abstract class MemoryInfoError {
  /// Descriptive string error message.
  external String message;

  external factory MemoryInfoError({String message});
}

/// The interface for messages sent and received to the [MessageProvider]
@anonymous
@JS()
abstract class Message<T> {
  external T data;
  external String /* MessageActions */ message;
  external factory Message({T data, String /* MessageActions */ message});
}

/// Message interface that any device or mock device must fulfill to integrate with [Client].
@anonymous
@JS()
abstract class MessageProvider {
  /// Register the callback for when events from the device are received.
  external set receive(MessageCallback callback);

  /// Sends the command and payload to the device or service responsible for handling events.
  ///
  /// The [command] is used to route events to the correct device or service handler.
  /// The [payload] is the data that will be used with the command by the device or service.
  ///
  /// A future that contains the [MessageSendResponse] result is returned once resolved succesfully.
  external dynamic /* Promise<MessageSendResponse> */ send(
    String command,
    dynamic payload,
  );

  external factory MessageProvider();
}

/// The status of the message sent to the device.
@anonymous
@JS()
abstract class MessageSendResponse {
  /// The limit on the number of outgoing requests
  /// from your web app
  external RateLimit rateLimit;

  /// A text string that describes the error value found in the
  /// [statusCode] property.
  external String reason;

  /// The HTTP status code that indicates the status of the received
  /// message from the skill.
  ///
  /// Valid values: 2XX (OK), 401 (Unauthorized), 429(Too Many Requests),
  /// 500 (Internal Server Error/Unknown Error), 5XX (Failure)
  external num statusCode;

  external factory MessageSendResponse({
    RateLimit rateLimit,
    String reason,
    num statusCode,
  });
}

/// The Microphone object provides information about the device.
@anonymous
@JS()
abstract class Microphone {
  /// Specifies whether the microphone activates when a user presses a
  /// physical button on the device or when a user uses a remote.
  external bool supportsPushToTalk;

  /// Specifies whether the microphone activates when a users says a wake word.
  ///
  /// When set to true, the web app can use the Voice interface to initiate
  /// microphone events.
  external bool supportsWakeWord;

  external factory Microphone({
    bool supportsPushToTalk,
    bool supportsWakeWord,
  });
}

/// Responsible for performance level metrics such as getting the current available memory.
@anonymous
@JS()
abstract class Performance {
  /// Retrieve information about the system memory.
  /// Memory information can be used to manage your application's memory consumption.
  /// It is not recommended to use this API in production and is provided for debug purposes only.
  /// Invoking this API may also impact device performance. Polling is not recommended.
  external MemoryInfo getMemoryInfo();
  external factory Performance();
}

/// The RateLimit object defines the limit on the number of outgoing
/// requests from your web app.
@anonymous
@JS()
abstract class RateLimit {
  /// The maximum allowed requests per second.
  external num maxRequestsPerSecond;

  /// The number of requests that might be delivered before the rate limiter blocks messages.
  ///
  /// 0 indicates no more messages are allowed.
  external num remainingRequests;

  /// The number of milliseconds until your app can send the next message.
  external num timeUntilNextRequestMs;

  /// The number of milliseconds until remainingRequests equals maxRequestsPerSecond.
  external num timeUntilResetMs;

  external factory RateLimit({
    num maxRequestsPerSecond,
    num remainingRequests,
    num timeUntilNextRequestMs,
    num timeUntilResetMs,
  });
}

/// Commands to interact with your skill backend.
@anonymous
@JS()
abstract class Skill {
  /// This function is used to register a listener for incoming messages sent from the skill.
  /// The messages received are independent of the messages sent from the HTML application via sendMessage.
  /// The message payload can be any data type.
  Skill onMessage(OnMessageCallback callback);

  /// This function allows the HTML application to communicate with the skill that invoked it.
  /// The message payload can be any data type.

  /// NOTE: This function is rate limited and calls may not always be successful.
  /// To handle the throttling error (or any other error), please supply the optional
  /// callback argument to the function. The callback always returns the status of the send
  /// and any error will be equivalent to HTTP status code. For example rate limit will be a
  /// 429 status and general error will be 500, while a success will be 200.*
  Skill sendMessage(
    dynamic message,
    MessageSendResponseCallback? callback,
  );

  external factory Skill();
}

/// Commands to react to speech events.
@anonymous
@JS()
abstract class Speech {
  /// This function is used to register a listener for when Alexa speech has started
  external Speech onStarted(VoidCallback callback);

  /// This function is used to register a listener for when Alexa speech has stopped
  external Speech onStopped(VoidCallback callback);

  external factory Speech();
}

/// Data that describe the speech that you synthesize, such as where a sentence or
/// word starts and ends in the audio stream. for more information on Speech Marks
/// visit, https://docs.aws.amazon.com/polly/latest/dg/speechmarks.html
@anonymous
@JS()
abstract class SpeechMark {
  /// The offset in bytes (not characters) of the object's end in the input text (not including viseme marks)
  external String end;

  /// The offset in bytes (not characters) of the start of the object in the input text (not including viseme marks)
  external String start;

  /// The timestamp in milliseconds from the beginning of the corresponding audio stream
  external String time;

  /// The type of speech mark (sentence, word, viseme, or ssml)
  external String type;

  /// This varies depending on the type of speech mark
  /// SSML: SSML tag
  /// word or sentence: a substring of the input text, as delimited by the start and end fields
  external String value;

  external factory SpeechMark({
    String end,
    String start,
    String time,
    String type,
    String value,
  });
}

/// Utility functions associated with managing speech.
@anonymous
@JS()
abstract class SpeechUtils {
  /// This function is used to fetch and demux an Alexa transformed speech mp3.
  external AudioData fetchAndDemuxMP3(String url);

  external factory SpeechUtils();
}

/// Collection of utility objects and functions that aid in development.
@anonymous
@JS()
abstract class Utils {
  /// Utility functions associated with managing speech.
  external SpeechUtils speech;

  external factory Utils({SpeechUtils speech});
}

/// Commands to react to voice user input.

/// NOTE: The device can send microphone events independently of whether or not
/// the microphone event was initiated by the skill or the user.
@anonymous
@JS()
abstract class Voice {
  /// This function is used to register a listener for microphone closed events coming from
  /// the device.
  external Speech onMicrophoneClosed(VoidCallback callback);

  /// This function is used to register a listener for microphone open events from the device.
  external Speech onMicrophoneOpened(VoidCallback callback);

  /// Make a request to open the microphone on the device to accept user utterances.
  external Speech requestMicrophoneOpen([VoiceArgs? config]);

  external factory Voice();
}

/// Configuration arguments of a microphone open request.
@anonymous
@JS()
abstract class VoiceArgs {
  /// Optional callback function that will be called when the microphone closes at the end of
  /// a successful request.
  external VoidCallback? onClosed;

  /// Optional callback function that will be called if the microphone request is unsuccessful
  /// due to an error. This includes cases where the request was denied because the
  /// microphone was already opened
  external MicrophoneOpenedErrorCallback? onError;

  /// Optional callback function that will be called when the microphone
  /// opens if the request is successful.
  external VoidCallback? onOpened;

  external factory VoiceArgs({
    VoidCallback? onClosed,
    MicrophoneOpenedErrorCallback? onError,
    VoidCallback? onOpened,
  });
}

/// These are all the HTML to Device Message Definitions
class MessageActions {
  static const String alexaHtmlReady = 'alexa-html-ready';
  static const String messageToHtml = 'message-to-html';
  static const String ttsStarted = 'tts-started';
  static const String ttsStopped = 'tts-stopped';
  static const String micEvent = 'mic-event';
  static const String micRequestedEvent = 'mic-requested-event';
  static const String memoryAvailable = 'memory-available';
}

/// These are all the values the error could be for [MicrophoneOpenedErrorCallback]
class MicrophoneOpenedError {
  static const String microphoneAlreadyOpen = 'microphone-already-open';
  static const String requestOpenUnsupported = 'request-open-unsupported';
  static const String tooManyRequests = 'too-many-requests';
  static const String unknown = 'unknown';
}

/// These are all the values the error could be [ErrorWithCode.code]
class ErrorCode {
  static const String noSuchVersion = 'no-such-version';
  static const String unauthorizedAccess = 'unauthorized-access';
  static const String tooManyRequests = 'too-many-requests';
  static const String unknown = 'unknown';
}
