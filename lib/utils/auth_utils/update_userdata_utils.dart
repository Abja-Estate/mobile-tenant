import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class UpdateUtil {
  static Future<String> update(GlobalKey<FormState> formkey,
      BuildContext context, Map<String, dynamic> loginData) async {
    // print(loginData);
    //var token2 = await showToken();
    //var id2 = await showId();

    var result;
    await saveEmail(loginData['email']);
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      Provider.of<AuthProvider>(context, listen: false)
          .login(
        loginData['email'],
        loginData['password'],
      )
          .then((value) async {
        print(value);
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
          print("yes ${value}");
          // formkey.currentState!.reset();
          await saveId(value['data']['id'].toString());
          await saveEmail(value['data']['email']);
          await saveName(value['data']['name']);
          await savePhone(value['data']['phone']);
          await saveSurname(value['data']['surname']);
          await saveRef(value['data']['refcode']);
          await saveOnce(3);
          await setSecured(value['data']['status']);
          Navigator.of(context).popAndPushNamed(AppRoutes.dashboardScreen);
        } else {
          if (value['statusCode'] == 404) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Sign Up',
                'Try again',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.registerScreen));
          }
          if (value['statusCode'] == 403) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Enter OTP',
                'Close',
                () => Navigator.of(context)
                    .pushNamed(AppRoutes.registerOTPScreen));
          }

          if (value['statusCode'] == 302 && value['data']['status'] == false) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['data'],
                'Contact Support',
                'Close',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.registerScreen));
          }
        }
      });
    }

    return result;
  }
}
