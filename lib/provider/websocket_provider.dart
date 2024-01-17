import 'package:abjatenant/utils/local_storage.dart';
import 'package:abjatenant/utils/notification_util.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketProvider extends ChangeNotifier {
  late WebSocketChannel _channel;

  WebSocketProvider() {
    var id = showuuId();
    var wsUrl = 'wss://casmara-request-app-api.onrender.com/ws?id=$id';
    var headers = {'Authorization': 'Ayoseun'};
    _channel = IOWebSocketChannel.connect(wsUrl, headers: headers);
    _channel.stream.listen((message) {
      print(message);
      if (message == "Connected") {
      } else if (message == "Delivered.✔️") {
        notify("Request", "Request has been $message");
      } else if (message == "Delivered.✔️✔️") {
        notify("Request", "Your Request has been $message");
      }
    });
  }

  WebSocketChannel get channel => _channel;

  void sendMessage(String message) {
    _channel.sink.add(message);
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
