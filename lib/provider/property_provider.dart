import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../network/property.dart';
import '../utils/local_storage.dart';

class PropertyProvider extends ChangeNotifier {
  Map<String, dynamic> _property = {};
  List _rent = [];

  PropertyProvider() {
    getPropertyItems();
    getRentItems();
  }

  Map<String, dynamic> get property => _property;
  List get rent => _rent;

  Future<Map<String, dynamic>> accessCode(code) async {
    dynamic data;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();

    try {
      var responseData = await PropertyAPI.accessCode(code);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();

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

  Future<Map<String, dynamic>> switchAccount(code, email) async {
    dynamic data;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();

    try {
      var responseData = await PropertyAPI.switchAccount(code, email);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();

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

  Future<void> getPropertyItems() async {
    notifyListeners();

    var propertyString = await showPropertyData();
    var getproperty = Map<String, dynamic>.from(jsonDecode(propertyString));

    if (getproperty.isNotEmpty) {
      print(getproperty);
      _property = getproperty;
      await saveLandlordID(getproperty['data']['landlordID']);
    }

    notifyListeners();
  }

  Future<void> getRentItems() async {
    notifyListeners();

    var rentsString = await showRentItem();

    var getRents = List.from(jsonDecode(rentsString));

    if (getRents.isNotEmpty) {
      _rent = getRents;
      print(_rent);
    } else {
      _rent = [];
    }

    notifyListeners();
  }
}
