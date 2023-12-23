import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class UpdateUtil {
  static Future<String> update(GlobalKey<FormState> formkey,
      BuildContext context, Map<String, dynamic> updateData) async {
     print(updateData);


    var result;

    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      Provider.of<AuthProvider>(context, listen: false)
          .update(
              updateData['email'],
              updateData['phone'],
              updateData['password'],
              updateData['confirmPassword'],
              updateData['name'],
              updateData['surname'],
              updateData['about'],
              updateData['token'])
          .then((value) async {
        print(value);
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
       
          // formkey.currentState!.reset();
          await saveSelfie(value['data']['selfie']);
       
         // Navigator.of(context).popAndPushNamed(AppRoutes.dashboardScreen);
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

          if (value['statusCode'] == 302) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
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
