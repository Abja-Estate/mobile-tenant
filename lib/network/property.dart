import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';
import '../utils/local_storage.dart';

class PropertyAPI {
  static Future addProperty(data) async {
    var id = await showId();
    var accessToken = await showAccessToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/add_property'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
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

    return parsedResponse;
  }

  static Future getAllProperty() async {
    var id = await showId();
    var accessToken = await showAccessToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/properties'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"id": id!}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future getProperty(propid) async {
    var accessToken = await showAccessToken();
    var id = await showId();
    var response = await http.post(
      Uri.parse('$BaseURL/service/tenant/propertybyid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(
          <String, String>{"id": id!, "propertyID": propid.toString()}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future uploadImage(selfie) async {
    var accessToken = await showAccessToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/upload'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"selfie": selfie}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future accessCode(code) async {
    var accessToken = await showAccessToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/tenant/verify_access'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"unitID": code}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future switchAccount(code, email) async {
    var accessToken = await showAccessToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/tenant/switch_account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{
        "unitID": code,
        "email": email,
      }),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }
}
