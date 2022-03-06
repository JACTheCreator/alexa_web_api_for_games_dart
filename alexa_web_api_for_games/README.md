[![Build Status](https://github.com/jacthecreator/alexa_web_api_for_games_dart/actions/workflows/alexa_web_api_for_games.yml/badge.svg)](https://github.com/jacthecreator/alexa_web_api_for_games_dart/actions/workflows/alexa_web_api_for_games.yml)

A Dart-JavaScript interoperability for Alexa Web API for Games. Alexa Web API for Games lets you create rich, immersive voice-enabled games by combining Alexa Skills Kit (ASK) directives with familiar web technologies.

## Features

### Alexa Objects - Client

| Property     | Description                                                                                                                                                                                                                                                                                                                                     | Supported |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| capabilities | The device capabilities.<br />For details, see [Microphone](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-build-your-webapp.html#microphone) and [Capability](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-build-your-webapp.html#capability).                                     | ✅        |
| performance  | Provides the interface to get the available memory on the device. <br />For details, see [Performance](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-build-your-webapp.html#performance).                                                                                                                         | ✅        |
| skill        | Provides the interfaces to communicate with your skill.<br/>For details, see [`onMessage`](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-build-your-webapp.html#on-message) and [`sendMessage`](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-build-your-webapp.html#send-message). | ✅        |
| speech       | Provides the interfaces to receive Alexa speech events.<br/>For details, see [Alexa Speech Input](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/add-voice-control-and-speech-to-the-web-app.html#alexa-speak).                                                                                                                | ✅        |
| version      | Version of the Alexa client.<br/>If you don't specify a version, the latest version is used.                                                                                                                                                                                                                                                    | ✅        |
| voice        | Provides the interfaces to open the microphone on the device to receive user utterances.<br/>For details, see [Alexa Voice](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/add-voice-control-and-speech-to-the-web-app.html#prompt-for-voice-javascript).                                                                      | ✅        |

### Functions

| Property | Description                                                                                                                                                                                                                                            | Supported |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- |
| create   | Establish the connection to Alexa on the device. When the future is completed successfully, an AlexaReadyPayload object is returned. Otherwise, when the future completes with an error, an ErrorWithCode object is returned. For details, see create. | ➖ \*     |

\*Even though a `MessageProvider` can be passed as an parameter in the `Alexa.create` function, doing this will cause an exception to be thrown.

### Extensions

| Property       | Description                                                                                                                                                                                                                                                                  | Supported |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| Entity-Sensing | Alexa-enabled devices with _entity-sensing_ capabilities can detect the presence of the user.<br />For details, see [Entity-Sensing](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-extensions-entitysensing.html).                             | ❌        |
| Smart-Motion   | Alexa-enabled devices with _smart-motion_ capabilities can rotate the device screen to turn toward and follow engaged users. <br />For details, see [Smart-Motion](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-extensions-smartmotion.html). | ❌        |

##### Legend

✅ Supported

❌ Not supported

➖ Partially supported

## Usage

### Add the Alexa JavaScript library to your app

To load the Alexa JavaScript library, include the URL in a script tag on your HTML page, as shown in the following example.

```html
<head>
  <script src="https://cdn.html.games.alexa.a2z.com/alexa-html/latest/alexa-html.js"></script>
</head>
```

### Create the Alexa client

Your app communicates with the device and with your skill with the Alexa `Client` object. To prevent the client from being available before it's ready to serve requests, create the Alexa `Client` object with a static factory function. Invoke the function one time on each page.

The following example shows Alexa `Client` object initialization.

```dart
Alexa.create(CreateClientOptions(version: '1.1')).then((args) {
  AlexaReadyPayload alexaClient = args.alexa;
  querySelector('#debugElement')?.innerHtml = 'Alexa is ready :)';
}).onError((ErrorWithCode error, stackTrace) {
  querySelector('#debugElement')?.innerHtml = 'Alexa not ready :(';
});
```

### Capabilities

Check the device capabilities using the `capabilities` interface.

The following example shows a check for PushToTalk capability using a [`Microphone`](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-build-your-webapp.html#microphone)object.

```dart
if (alexaClient.capabilities.microphone.supportsPushToTalk) {
  // Prompt the user to press the microphone button
  ...
};
```

The following example shows a check for WakeWord capability using a [`Microphone`](https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/alexa-games-build-your-webapp.html#microphone)object.

```dart
if (alexaClient.capabilities.microphone.supportsWakeWord) {
  // Prompt the user to press the microphone button
  ...
};
```

### Performance

Use the performance interface to get the available memory on the device. This interface is useful in development for optimizing assets and debugging across device types.

**Important:** Don't use the performance interface in production because the invocation can negatively affect device performance.

The following example shows logging the available memory.

```dart
alexaClient.performance.getMemoryInfo().then((memInfo) => {
  // log memInfo
}).onError((MemoryInfoError error, stackTrace) {
  // log error caused by memInfo
});
```

### onMessage

Use the `alexaClient.skill.onMessage` to register a listener to handle messages sent from your skill. The messages sent to your listener are independent of the messages your app sends to your skill. The format of the `message` sent from the skill is agreed on between the app and the skill. The app can only register one callback, so the callback function should include logic to handle different messages based on the data provided within the `message`. Messages can't be received until you register the listener. If you need information from the skill on start-up, use the `message` returned in the successful `create` interface.

The following example shows registering a listener function called `messageReceivedCallback`.

```dart
main() {
  // Register a listener to receive a message from your skill
  alexaClient.skill.onMessage(allowInterop(_messageReceivedCallback));
}

// Implement the listener
void _messageReceivedCallback(dynamic message) {
  // Process message (JavaScript object) from your skill
};
```

### sendMessage

To send a message to your skill from your web app, use `alexaClient.skill.sendMessage` interface. The interface takes a data payload and an optional callback for handling the response. The API results in an `Alexa.Presentation.HTML.Message` to your skill.

**Important:** You can't send more than two messages per second to the skill. Use the optional callback on `alexa.skill.sendMessage()` to catch throttling errors caused when your app exceeds this limit. The `MessageSendResponse` returns error 429 (Too Many Requests) to your callback.

The following example shows sending a message to the skill.

```dart
main() {
  // Send a message to your skill
  alexaClient.skill.sendMessage(message, allowInterop(_messageSentCallback));
}

// Check the results of the MessageSendResponse
void _messageReceivedCallback(MessageSendResponse sendResponse) {
  // Handle response codes
};
```

## Known Issues

- As stated above, passing a `MessageProvider` in `Alexa.create` will cause an Exception.
- Currently Extensions are not supported.
- For more know issues, please see https://developer.amazon.com/en-US/docs/alexa/web-api-for-games/known-issues.html.

## Contributing to this package

If you would like to contribute to the plugin, check out our [contribution guide]().

## Disclaimers

This is not an Amazon product.
