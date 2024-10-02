import 'package:abjatenant/utils/app_utils.dart';
import 'package:abjatenant/utils/local_storage.dart';
import 'package:abjatenant/utils/notification_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../constants/resources.dart';

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

  Future<void> listenStream() async {
    notifyListeners();
    _channel.stream.listen(
      (message) {
        print(message);
        if (message == "Connected") {
         
        } else if (message == "Sent.✔️") {
          _result = true;
          notifyListeners();
          notify("Request", "Request has being Sent.✔️", true);
        } else if (message == "Seen.✔️✔️") {
          _result = true;
          notifyListeners();
          notify("Request", "Your Request has been Recieved.✔️✔️", true);
        } else {
          _result = false;
        }
      },
      onDone: () {
        // Handle WebSocket stream closed, and initiate a reconnection
        init();
      },
      onError: (error) {
        print(error);
        // notify("Request Failed", "Your Request failed to deliver try again",
        //     false);
      },
    );
  }

  init() async {
    var id = await showUnitId();
    print(id);
    var accessToken = await showAccessToken();
    var wsUrl = '$WebsocketURL?id=$id';
    var headers = {
      'x-api-key': WebsocketAPIKEY,
      'Authorization': 'Bearer $accessToken'
    };
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
