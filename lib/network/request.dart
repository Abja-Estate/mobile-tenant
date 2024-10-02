import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';
import '../utils/local_storage.dart';

class RequestAPI {

  static Future getAllRequest(uid, email) async {
    var accessToken = await showAccessToken();
    var response = await http.post(
      Uri.parse('$BaseURL/request/tenant/all_unit_request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"email": email, "unitID": uid}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }
}
