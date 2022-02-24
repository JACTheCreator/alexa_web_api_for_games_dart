import 'dart:async';
import 'dart:html';

import 'package:alexa_web_api/alexa_web_api.dart';

Element? status = querySelector('#status');

Future<void> main() async {
  try {
    AlexaReadyPayload payload = await Alexa.create(
      CreateClientOptions(version: '1.1'),
    );

    loadPerformaceMonitor(payload.alexa);
  } on ErrorWithCode catch (e) {
    status?.text = 'Status: ${e.message} | ${e.code}';
  } catch (e) {
    status?.text = 'Status: $e';
  }
}

void loadPerformaceMonitor(Client alexa) {
  var availableMemory = querySelector('#available-memory');
  var supportsPushtoTalk = querySelector('#push-to-talk');
  var supportsWakeWord = querySelector('#wake-word');
  querySelectorAll('.ending').forEach((element) {
    element.style.display = "inline";
  });

  status?.text = 'Status: Alexa is Ready :D';

  promiseToStream<MemoryInfo, MemoryInfoError>(
    alexa.performance.getMemoryInfo,
  ).listen((event) {
    availableMemory?.text = '${event.availableMemoryInMB}';
  }).onError((error) {
    if (error is MemoryInfoError) {
      status?.text = 'Status: ${error.message}';
    } else {
      status?.text = 'Status: $error}';
    }
  });

  var microphone = alexa.capabilities.microphone;
  supportsPushtoTalk?.text =
      microphone.supportsPushToTalk.toString().toUpperCase();
  supportsWakeWord?.text = microphone.supportsWakeWord.toString().toUpperCase();
}
