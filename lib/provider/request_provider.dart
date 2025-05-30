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
    var unitId = await showUnitId();
    var email = await showEmail();
    print(unitId);
    try {
      var responseData =
          await RequestAPI.getAllRequest(unitId, email);

      if (responseData['statusCode'] == 200) {
        _request = List<Map<String, dynamic>>.from(responseData['data']);
    
        notifyListeners();
      } else {
        print(responseData);
        // Additional error handling or logging can be added here
      }
    } catch (e) {
    
      _request = [];
      // Additional error handling or logging can be added here
    }
  }
}
