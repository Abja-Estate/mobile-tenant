import 'dart:convert';
import 'package:abjatenant/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';

class AuthAPI {
  static Future OTPVerfication(email, token, otp) async {
    var accessToken = await showAPIAccessCode();
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/verify_otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(
          <String, String>{"email": email, "otp": otp, "token": token}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future register(
      firstName, lastName, password, confirmPassword, email, phone) async {
    var code = await showAccessCode();
    var payload = {
      "name": firstName,
      "surname": lastName,
      "email": email,
      "phone": phone,
      "password": password,
      "confirmPassword": confirmPassword,
      "accessCode": code
    };

    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
      },
      body: jsonEncode(payload),
    );
    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future login(data, password) async {
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
      },
      body: jsonEncode(<String, String>{"email": data, "password": password}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future forgotPassword(email) async {
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/forgot_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
      },
      body: jsonEncode(<String, String>{"email": email}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future resetPassword(id, cpassword, password) async {
    var accessToken = await showAPIAccessCode();
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/reset_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "password": password,
        "confirmPassword": cpassword
      }),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future selfie(email, token, selfie) async {
    var accessToken = await showAPIAccessCode();
    var response = await http.put(
      Uri.parse('$BaseURL/auth/landlord/selfie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(
          <String, String>{"email": email, "token": token, "selfie": selfie}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future refresh(email) async {
    var accessToken = await showAPIAccessCode();
    var response = await http.put(
      Uri.parse('$BaseURL/auth/landlord/refresh_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"email": email}),
    );
    var parsedResponse = jsonDecode(response.body);
    return parsedResponse;
  }

  static Future updateData(phone, name, surname, about, selfie) async {
    var accessToken = await showAPIAccessCode();
    var id = await showId();
    var response = await http.put(
      Uri.parse('$BaseURL/auth/tenant/update_tenant'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "phone": phone,
        "name": name,
        "surname": surname,
        "about": about,
        "selfie": selfie
      }),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }
}
