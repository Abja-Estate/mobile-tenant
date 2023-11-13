import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../network/auth.dart';
import '../utils/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  // final Map<String, dynamic> serverErrorResult = {
  //   'status': false,
  //   'message': 'Sorry, something went wrong. Contact the Admin',
  // };

  Future<Map<String, dynamic>> login(email, password) async {
    dynamic data;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();

    try {
      var responseData = await AuthAPI.login(email, password);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();
        print(data);
        data;
      } else {
        data;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<Map<String, dynamic>> registerOTP(id,otp) async {
    dynamic data;

    notifyListeners();

    try {
      var responseData  = await AuthAPI.OTPVerfication(id,otp);
      
      if (responseData['statusCode'] == 200) {
        notifyListeners();
        data = responseData;
        print(data);
      } else {
        data = responseData;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<Map<String, dynamic>> register(
      firstName, lastName, password, confirmPassword, email, phone,ref) async {
    dynamic data;
    notifyListeners();

    try {
      var responseData = await AuthAPI.register(
          firstName, lastName, password, confirmPassword, email, phone,ref);

      print(responseData);
      if (responseData['statusCode'] == 200) {
        notifyListeners();

        data = responseData;
      } else {
        data = responseData;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<Map<String, dynamic>> forgotPassword(email) async {
    dynamic data;
    notifyListeners();

    try {
      var response = await AuthAPI.forgotPassword(email);

      if (response != null) {
        notifyListeners();
        print(response);
        data = response;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<Map<String, dynamic>> changePassword(password) async {
    dynamic data;
    notifyListeners();
    var id = await showId();
    print(id);
    print(password);
    try {
      var response = await AuthAPI.resetPassword(id, password);
      var responseData = json.decode(response.body);
      if (responseData != null) {
        notifyListeners();

        data = responseData;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }
}
