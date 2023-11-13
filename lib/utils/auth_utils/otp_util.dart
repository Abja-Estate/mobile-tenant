import 'dart:io';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class RegisterOTPUtil {
  static Future<String> register(
      BuildContext context, Map<String, dynamic> resetData) async {
    print(resetData);
    AppUtils.showLoader(context);
    var result;
    var id = await showId();
    Provider.of<AuthProvider>(context, listen: false)
        .registerOTP(id, resetData['otp'])
        .then((value) async {
      Navigator.of(context).pop();
      print(value);
      if (value['statusCode'] != 200) {
        AppUtils.ErrorDialog(
          context,
          'Error',
          value['data'],
          'Close',
          Icon(
            Icons.error_rounded,
            color: Color.fromARGB(255, 213, 10, 10),
            size: 30,
          ),
        );
      } else {
        Navigator.of(context).pushNamed(AppRoutes.loginScreen);
      }
    });

    return result;
  }
}
