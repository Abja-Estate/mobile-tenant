import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../network/property.dart';
import '../utils/local_storage.dart';

class PropertyProvider extends ChangeNotifier {
  Map<String, dynamic> _property = {};
  bool _refresh = false;
  List _rent = [];
  int _activeRents = 0;

  PropertyProvider() {
    getPropertyItems();
    getRentItems();
  }

  Map<String, dynamic> get property => _property;
  List get rent => _rent;
  int get activeRents => _activeRents;
  bool get refresh => _refresh;
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
        await saveUnitData(responseData['data']['data']);
        await savePropertyData(responseData['data']);
      } else {
        data;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<Map<String, dynamic>> validateAccount() async {
    dynamic data;
    _refresh = false;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();
    var access = await showAccessCode();
    var email = await showEmail();
    try {
      var responseData = await PropertyAPI.switchAccount(access, email);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();

        data;
        await saveUnitData(responseData['data']['data']);
        await savePropertyData(responseData['data']);

          _refresh = true;
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

    var rentsString = await showRentHistory();

    var getRents = List.from(jsonDecode(rentsString));

    if (getRents.isNotEmpty) {
      _rent = getRents;
      print(_rent);
      List<dynamic> filteredRents =
          getRents.where((rent) => rent['duration'] > 0).toList();
      _activeRents = filteredRents.length;
      print(filteredRents);
    } else {
      _rent = [];
    }

    notifyListeners();
  }
}
