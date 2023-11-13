import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences s_prefs;

saveRef(token) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("token", token);
}

saveCartItem(cartItems) async {
  print(cartItems);
  s_prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(cartItems);
  s_prefs.setString("cartItem", jsonString);
}

saveName(name) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("name", name);
}

saveUserState(ustate) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("userstate", ustate);
}

saveSurname(surname) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("surname", surname);
}

savePhone(cred) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("phone", cred);
}

saveCity(city) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("city", city);
}

saveEmail(email) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("email", email);
}

setSecured(secured) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setBool("secured", secured);
}

saveId(id) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("id", id);
}

showCartItem() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("cartItem");

  return temp;
}

showName() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("name");

  return temp;
}

showPhone() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("phone");

  return temp;
}

showState() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("userstate");

  return temp;
}

showCity() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("city");

  return temp;
}

showSurname() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("surname");

  return temp;
}

isSecured() async {
  s_prefs = await SharedPreferences.getInstance();

  bool? temp = s_prefs.getBool("secured");

  return temp;
}

showUsername() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("username");

  return temp;
}

showRef() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("token");

  return temp;
}

showEmail() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("email");

  return temp;
}

showId() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("id");

  return temp;
}

clear() async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.clear();
}

//end BNB wallet

//Polywallet

saveNotify(Poly) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setInt("Poly", Poly);
}

saveOnce(once) async {
  print(once);
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setInt("Once", once);
}

saveWssConnect(once) async {
  print(once);
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setBool("active", once);
}

showOnce() async {
  s_prefs = await SharedPreferences.getInstance();

  int? temp = s_prefs.getInt("Once");

  temp ??= 0;
  print(temp);
  return temp;
}
showWssConnect() async {
  s_prefs = await SharedPreferences.getInstance();

  bool? temp = s_prefs.getBool("active");

  temp ??= false;
  print(temp);
  return temp;
}
showNotify() async {
  s_prefs = await SharedPreferences.getInstance();

  int? temp = s_prefs.getInt("Poly");

  return temp;
}

savePolypk(Polypk) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("Polypk", Polypk);
}

showPolypk() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("Polypk");

  return temp;
}

delete_cart() async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.remove("cartItem");

  //temp = " ";
}

class Storage {
  static Future balance(String Save) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('balance', Save);
    // print('object');
  }

  static Future<dynamic> getAlreadyAUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool('alreadyAUser');
    return value;
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', 123);
  }

  static Future oneTime<int>() async {
    var once = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', once);
    if (once == 0) {
      prefs.setInt('intValue', once);
    } else {
      return once;
    }
  }

  addDoubleToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('doubleValue', 115.0);
  }

  static Future<dynamic> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dynamic tokenMap = token == null ? 'null' : jsonDecode(token) as dynamic;
    return tokenMap;
  }

  static Future<bool> setToken(dynamic token) async {
    var commit = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', jsonEncode(token));
    commit = true;
    return commit;
  }

  static void removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
  }

  static getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('balance');
    return stringValue!;
  }

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool('boolValue');
    return boolValue;
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt('intValue');
    return intValue;
  }

  getDoubleValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double? doubleValue = prefs.getDouble('doubleValue');
    return doubleValue;
  }
}
