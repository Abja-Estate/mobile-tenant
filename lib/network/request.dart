import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';
import '../utils/local_storage.dart';

class RequestAPI {
  static Future addProperty(data) async {
    var id = await showId();
    print(data);
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/add_property'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(<String, dynamic>{
        "landlordID": id,
        "propertyID": data['propertyID'],
        "name": data['name'],
        "description": data['description'],
        "unit": data['unit'],
        "category": data['category'],
        "structure": data['structure'],
        "type": data['type'],
        "location": data['location'],
        "photo": data['photo'],
        "unitData": data['unitData'],
        "football": data['football'],
        "pool": data['pool'],
        "wifi": data['wifi'],
        "laundry": data['laundry'],
        "garden": data['garden'],
        "fitness": data['fitness'],
        "power": data['power']
      }),
    );

    var parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse;
  }

  static Future getAllRequest(uid,lid) async {
    
    var response = await http.post(
      Uri.parse('$BaseURL/request/tenant/all_unit_request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(<String, String>{"landlordID": lid,"unitID": uid}),
    );

    var parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse;
  }

  static Future getProperty(propid) async {
    print(propid);
    var id = await showId();
    var response = await http.post(
      Uri.parse('$BaseURL/service/tenant/propertybyid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(
          <String, String>{"id": id, "propertyID": propid.toString()}),
    );

    var parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse;
  }

  static Future resetPassword(id, token, cpassword, password) async {
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/reset_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "token": token,
        "password": password,
        "confirmPassword": cpassword
      }),
    );

    var parsedResponse = jsonDecode(response.body);

    print(parsedResponse);

    return parsedResponse;
  }

  static Future uploadImage(selfie) async {
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/upload'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(<String, String>{"selfie": selfie}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future refresh(email) async {
    print(email);
    var response = await http.put(
      Uri.parse('$BaseURL/auth/landlord/refresh_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(<String, String>{"email": email}),
    );
    var parsedResponse = jsonDecode(response.body);
    return parsedResponse;
  }

  static Future accessCode(code) async {
     print(code);
    var response = await http.post(
      Uri.parse('$BaseURL/service/tenant/verify_access'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(<String, String>{
        "unitID": code
      }),
    );

    var parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse;
  }
}
