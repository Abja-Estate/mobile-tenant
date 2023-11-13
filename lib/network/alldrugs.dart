import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/resources.dart';

class StoreAPI {
//create a static promise method that ties quesry to api
  static Future oneProduct(id) async {
    //attach base to quesry

    var allURL = '$BaseURL/store/get-one-product/${id}';

    //return parsed api
    var res = await http.get(Uri.parse(allURL));
    return res;
  }

  //create a static promise method that ties quesry to api
  static Future searchProductByID(id) async {
    //attach base to quesry

    var allURL = '$BaseURL/store/get-one-product/${id}';

    //return parsed api
    var res = await http.get(Uri.parse(allURL));
    return res;
  }

  static Future OTPVerfications(email) async {
    //attach base to quesry
    var otpurl = "$BaseURL/store/get-products-by-name";
    final encoding = Encoding.getByName('utf-8');
    Map<String, dynamic> body = {"productname": "Allerex"};
    var jsonBody = json.encode(body);
    final headers = {'Content-Type': 'application/json'};
    //return parsed api
    var response = await http.post(
      Uri.parse(otpurl),
      encoding: encoding,
      body: json.encode(body),
    );

    var parsedResponse = jsonDecode(response.body);
    return parsedResponse;
  }

  static Future getProductByCategory(info) async {
    print(info);
    var response = await http.post(
      Uri.parse('$BaseURL/store/get-products-by-category'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"category": info}),
    );
    print(response);
    var parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse;
  }

  static Future getProductByName(data) async {
    var response = await http.post(
      Uri.parse('$BaseURL/store/get-products-by-name'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"productname": data}),
    );

    var parsedResponse = jsonDecode(response.body);

    print(parsedResponse);
    return parsedResponse;
  }

  static Future allProduct(page, limit) async {
    //attach base to quesry
    // Create a request body object with the limit parameter

    var allURL = '$BaseURL/store/get-all-products?page=$page&limit=$limit';

    //return parsed api
    var res = await http.get(Uri.parse(allURL));
    return res;
  }

  static Future allProducts() async {
    //attach base to quesry
    // Create a request body object with the limit parameter

    var allURL = '$BaseURL/store/get-all-products-without-limit';

    //return parsed api
    var res = await http.get(Uri.parse(allURL));
    return res;
  }

  static Future allProductCategory() async {
    //attach base to quesry
    // Create a request body object with the limit parameter

    var allURL = '$BaseURL/store/get-products-categories';

    //return parsed api
    var res = await http.get(Uri.parse(allURL));

    return res;
  }
}
