import 'dart:convert';
import 'package:abjatenant/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';

class AuthAPI {
  static Future OTPVerfication(email, token, otp) async {
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/verify_otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
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
    print(payload);
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(payload),
    );
    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future login(data, password) async {
    print(data);
    print(password);
    var response = await http.post(
      Uri.parse('$BaseURL/auth/tenant/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
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
        'authorization': APIKEY
      },
      body: jsonEncode(<String, String>{"email": email}),
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

  static Future selfie(email, token, selfie) async {
    print(email);
    print(token);
    var response = await http.put(
      Uri.parse('$BaseURL/auth/landlord/selfie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(
          <String, String>{"email": email, "token": token, "selfie": selfie}),
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

  static Future updateData(email, phone, password, confirmPassword, name,
      surname, about, token) async {
    var response = await http.put(
      Uri.parse('$BaseURL/auth/tenant/update_landlord'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': APIKEY
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "phone": phone,
        "password": password,
        "confirmPassword": confirmPassword,
        "name": name,
        "surname": surname,
        "about": about,
        "token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDIyMTc3OTAsImRhdGEiOiJheW9zZXVuc29sb21vbkBnbWFpbC5jb20kMmIkMTAkdy9vZHdFSjZ3ZVhBR081eHhrSklldS9FYnRYU2hsZ2lMcWlyMVBtT3QuZy5qTDZ4RUdKbkcyNDI1NTVBYmphV2h5U2F2ZTAwNz8iLCJpYXQiOjE3MDE4NTc3OTB9.5o0udhyxsi4Kznl4WPgk2fPAzwQTiCUzSRCF_mCk2kM"
      }),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }
}
