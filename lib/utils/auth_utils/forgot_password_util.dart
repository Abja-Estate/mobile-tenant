import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class ForgotPasswordUtil {
  static Future<String> forgotPassword(
      BuildContext context, Map<String, dynamic> forgotData) async {
    AppUtils.showLoader(context);
    await saveEmail(forgotData['data']);
    var result;
    Provider.of<AuthProvider>(context, listen: false)
        .forgotPassword(forgotData['data'])
        .then((value) async {
      Navigator.of(context).pop();
      print(value);
      if (value['statusCode'] != 200) {
        AppUtils.ErrorDialog(
          context,
          value['data'] ?? 'error',
          'User not found',
          'Close',
          Icon(
            Icons.error_rounded,
            color: Color.fromARGB(255, 213, 10, 27),
            size: 30,
          ),
        );
      } else {
        //TO DO
        await saveId(value['data'].toString());

        // IsFirstTime().once(2);
        Navigator.of(context).pushNamed(AppRoutes.resetOTPScreen);
      }
    });

    return result;
  }
}
