import 'package:abjatenant/utils/app_utils.dart';
import 'package:abjatenant/utils/local_storage.dart';
import 'package:abjatenant/utils/notification_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketProvider extends ChangeNotifier {
  late WebSocketChannel _channel;

  bool _result = false; // Initialize to false by default

  WebSocketProvider() {
    init();
  }

  WebSocketChannel get channel => _channel;
  bool get result => _result;

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void listenStream() async {
    _channel.stream.listen(
      (message) {
        print(message);

        if (message == "Connected") {
          // Handle connected scenario if needed
        } else if (message == "Delivered.✔️") {
          notify("Request", "Request is being $message", true);
        } else if (message == "Delivered.✔️✔️") {
          notify("Request", "Your Request has been $message", true);
        } else {
          // Handle other scenarios
        }

  
      },
      onDone: () {
        // Handle WebSocket stream closed, and initiate a reconnection
        init();
      },
      onError: (error) {
        print(error);
          // notify("Request Failed", "Your Request failed to deliver try again", false);
        // Handle WebSocket stream error if needed
      },
    );
  }

  init() async {
    var id = await showuuId();
    var wsUrl = 'wss://casmara-request-app-api.onrender.com/ws?id=$id';
    var headers = {'Authorization': 'Ayoseun'};
    _channel = IOWebSocketChannel.connect(wsUrl, headers: headers);
    listenStream();
  }

  void closeChannel() {
    _channel.sink.close(status.goingAway);
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
