import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';

class AuthAPI {
//create a static promise method that ties quesry to api
  static Future oneProduct(id) async {
    //attach base to quesry

    var allURL = '$BaseURL/get-one-product/${id}';

    //return parsed api
    var res = await http.get(Uri.parse(allURL));
    return res;
  }

  //create a static promise method that ties quesry to api
  static Future searchProductByID(id) async {
    //attach base to quesry

    var allURL = '$BaseURL/get-one-product/${id}';

    //return parsed api
    var res = await http.get(Uri.parse(allURL));
    return res;
  }

  static Future OTPVerfication(id, otp) async {
    var response = await http.put(
      Uri.parse('$BaseURL/users/verify-otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"id": id, "otpData": otp}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future register(
      firstName, lastName, password, confirmPassword, email, phone,ref) async {
    var payload = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "password": password,
      "confirmPassword": confirmPassword,
      "referred":ref
    };
    print(payload);
    var response = await http.post(
      Uri.parse('$BaseURL/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
      Uri.parse('$BaseURL/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"data": data.toString(), "password": password}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future forgotPassword(email) async {
    var response = await http.post(
        Uri.parse('$BaseURL/users/forgot-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email}),
      );

      var parsedResponse = jsonDecode(response.body);
      print(parsedResponse);
      return parsedResponse;
  }

  static Future resetPassword(id, password) async {
    var response = await http.patch(
      Uri.parse('$BaseURL/users/password-reset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"id": id, "password": password}),
    );

    var parsedResponse = response;

    return parsedResponse;
  }
}
