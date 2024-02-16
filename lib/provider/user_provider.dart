import 'dart:async';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:abjatenant/network/user.dart';
import 'package:abjatenant/utils/property_util/access_code_utils.dart';
import 'package:flutter/widgets.dart';
import '../network/property.dart';
import '../utils/app_utils.dart';
import '../utils/local_storage.dart';

class UserProvider extends ChangeNotifier {
  String _name = "";
  String _photo = "";
  List _historyData = [];
  bool _fetchingHistory = true;
  UserProvider() {
    getItems();
    getAllHistory();
  }

  String get name => _name;
  String get photo => _photo;
  List get history => _historyData;
  bool get fetchingHistory => _fetchingHistory;

  Future<void> getItems() async {
    notifyListeners();

    _name = await showName();
    // surname = await showSurname();
    _photo = await showSelfie();
    // code = await showAccessCode();
    // var mlocate =
    //     await getAddress(getUserLocation(_serviceEnabled, _permissionGranted));
    // print(mlocate['fullAddress'].toString());
    // fullAddress = mlocate['fullAddress'].toString();
    // await saveUserState(mlocate['state']);
    // await saveCity(mlocate['city']);

    // fullAddress;
    // fullname = "$name $surname";

    notifyListeners();
  }



  Future<void> getAllHistory() async {
    _fetchingHistory = true;
    notifyListeners();

    try {
      var responseData = await UserAPI.history();
 
      if (responseData['statusCode'] == 200) {
        _historyData = List<Map<String, dynamic>>.from(responseData['data']);
       
        _fetchingHistory = false;
        notifyListeners();
      } else {
        print(
            'Request API failed with status code: ${responseData['statusCode']}');
        // Additional error handling or logging can be added here
      }
    } catch (e) {
      print({'error': e.toString()});
      _historyData = [];
      // Additional error handling or logging can be added here
    }
  }
}
