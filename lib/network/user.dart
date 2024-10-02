import 'dart:convert';
import 'package:abjatenant/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';

class UserAPI {
  static Future history() async {
    var id = await showId();
        var accessToken = await showAccessToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/tenant/all_history'),
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
}
