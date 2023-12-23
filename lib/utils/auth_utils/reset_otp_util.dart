import 'dart:io';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class ResetOTPUtil {
  static Future<String> reset(BuildContext context, resetData) async {
    print(resetData);
    AppUtils.showLoader(context);
    var result;
    var email = await showEmail();
    var token = await showToken();
    print(token);
    print(email);
    Provider.of<AuthProvider>(context, listen: false)
        .registerOTP(email.toString(), token.toString(), resetData)
        .then((value) async {
      Navigator.of(context).pop();
      print(value);
      if (value['statusCode'] != 200) {
        AppUtils.ErrorDialog(
          context,
          'Error',
          value['error'].toString(),
          'Close',
          Icon(
            Icons.error_rounded,
            color: Color.fromARGB(255, 213, 10, 10),
            size: 30,
          ),
        );
      } else {
        Navigator.of(context).popAndPushNamed(AppRoutes.changePassword);
      }
    });

    return result;
  }
}
