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
    // print(loginData);
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
        registerData['firstName'].trim(),
        registerData['lastName'].trim(),
        registerData['password'].trim(),
        registerData['password'].trim(),
        registerData['email'].trim(),
        registerData['phone'].trim(),
         registerData['referred'].trim(),
      )
          .then((value) async {
        Navigator.of(context).pop();
        print(value);
        if (value['statusCode'] == 200) {
          formkey.currentState!.reset();
          await saveId(value['data'].toString());
          saveOnce(1);
          Navigator.of(context).pushNamed(AppRoutes.registerOTPScreen);
        } else {
          if (value['statusCode'] == 302) {
            AppUtils.ErrorDialog(
              context,
              'Ooops, seems you didn\'t get it right!',
              value['data'],
              'Close',
              const Icon(
                Icons.error,
                color: Color.fromARGB(255, 205, 5, 5),
                size: 30,
              ),
            );
          }
          if (value['statusCode'] == 400) {
            AppUtils.ErrorDialog(
              context,
              'Ooops, There seems to be an error!',
              value['data'],
              'Close',
              const Icon(
                Icons.error,
                color: Color.fromARGB(255, 205, 5, 5),
                size: 30,
              ),
            );
          }
          if (value['statusCode'] == 404) {
            AppUtils.ErrorDialog(
              context,
              'Ooops, seems this email is already taken!',
              value['data'],
              'Close',
              const Icon(
                Icons.error,
                color: Color.fromARGB(255, 205, 5, 5),
                size: 30,
              ),
            );
          }
          // } else {
          //   AppUtils.ErrorDialog(
          //     context,
          //     'Error',
          //     'User already exist',
          //     'Close',
          //   );
          // }
        }
      });
    }

    return result;
  }
}
