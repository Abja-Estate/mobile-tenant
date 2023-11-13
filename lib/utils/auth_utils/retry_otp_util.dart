import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class RetryOTPUtil {
  static Future<String> retry(BuildContext context) async {
    var email = await showEmail();
    var phone = await showPhone();
    AppUtils.showLoader(context);
    var result;
    Provider.of<AuthProvider>(context, listen: false)
        .forgotPassword(email)
        .then((value) async {
      Navigator.of(context).pop();
      print(value);
      if (value['statusCode'] != 200) {
        AppUtils.ErrorDialog(
          context,
          value['data']??"",
          'User not found',
          'Close',
          Icon(
            Icons.error_rounded,
            color: Color.fromARGB(255, 213, 10, 27),
            size: 30,
          ),
        );
      } else {
      AppUtils.ErrorDialog(
          context,
          "Sent",
          'An OTP has been resent to you',
          'Close',
          Icon(
            Icons.check_circle_outline_rounded,
            color: Color.fromARGB(255, 10, 213, 13),
            size: 30,
          ),
        );
      }
    });

    return result;
  }
}
