import 'dart:io';

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';

import '../../provider/auth_provider.dart';
import '../app_utils.dart';

class ResetPasswordUtil {
  static Future<String> resetPassword(
      BuildContext context, Map<String, dynamic> resetData) async {
    print(resetData);
    AppUtils.showLoader(context);
    var result;
    Provider.of<AuthProvider>(context, listen: false)
        .changePassword(resetData['password'])
        .then((value) async {
      Navigator.of(context).pop();
      print(value);
      if (value['statusCode'] != 200) {
        AppUtils.ErrorDialog(
          context,
          'Error',
          value['data'],
          'Close',
          const Icon(
            Icons.error_rounded,
            color: Color.fromARGB(255, 213, 10, 10),
            size: 30,
          ),
        );
      } else {
        AppUtils.successDialog(
            context,
           'Success',
            'You are',
            'Close',
            const Icon(
              Icons.error_rounded,
              color: Color.fromARGB(255, 213, 10, 10),
              size: 30,
            ),
            () => null);
        Navigator.of(context).pushNamed(AppRoutes.loginScreen);
      }
    });

    return result;
  }
}