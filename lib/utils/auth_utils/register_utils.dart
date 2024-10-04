import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class RegisterUtil {
  static Future<String> register(GlobalKey<FormState> formkey,
      BuildContext context, Map<String, dynamic> registerData) async {
    print(registerData);
    //var token2 = await showToken();
    //var id2 = await showId();
    await saveEmail(registerData['email']);
    await savePhone(registerData['phone']);
    var result;

    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      Provider.of<AuthProvider>(context, listen: false)
          .register(
              registerData['name'].trim(),
              registerData['surname'].trim(),
              registerData['password'].trim(),
              registerData['password'].trim(),
              registerData['email'].trim(),
              registerData['phone'].trim())
          .then((value) async {
        Navigator.of(context).pop();
        print(value);
        if (value['statusCode'] == 200) {
          formkey.currentState!.reset();

          saveOnce(1);
          await saveId(value['data']['_id'].toString());
         //await saveToken(value['data']['accessToken']);
          await saveEmail(value['data']['email']);
          Navigator.of(context).pushNamed(AppRoutes.registerOTPScreen);
        } else {
          AppUtils.ErrorDialog(
            context,
            'Ooops, seems you didn\'t get it right!',
            value['error'],
            'Close',
            const Icon(
              Icons.error,
              color: Color.fromARGB(255, 205, 5, 5),
              size: 30,
            ),
          );
        }
      });
    }
    return result;
  }
}
