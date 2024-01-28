import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../network/request.dart';
import '../utils/local_storage.dart';

class RequestProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _request = [];

  List<Map<String, dynamic>> get request => _request;

  RequestProvider() {
    getAllRequest();
  }

  Future<void> getAllRequest() async {
    notifyListeners();
    var uid = await showuuId();

    try {
      var responseData =
          await RequestAPI.getAllRequest(uid, "65aa32ab66281188b471fccc");
      print(responseData);
      if (responseData['statusCode'] == 200) {
        _request = List<Map<String, dynamic>>.from(responseData['data']);
        print(_request);
        notifyListeners();
      } else {
        print(
            'Request API failed with status code: ${responseData['statusCode']}');
        // Additional error handling or logging can be added here
      }
    } catch (e) {
      print({'error': e.toString()});
      _request = [];
      // Additional error handling or logging can be added here
    }
  }
}
