import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../provider/property_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class UserUtil {
  validateToken(
    BuildContext context,
  ) async {

    var token = await showAccessToken();
    print(token);
    try {
      DateTime expirationDate = JwtDecoder.getExpirationDate(token);
      DateTime currentDate = DateTime.now();

      // Check if the token is already expired
      if (currentDate.isAfter(expirationDate)) {
        await saveAccessToken("");
        await saveOnce(2);
        AppUtils.showSnackBarMessage(
            "Session Expired, Login to continue", context);
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.loginScreen,
          (route) => false,
        );
      }

      // Check if the token will expire within the next 5 minutes
      Duration timeUntilExpiration = expirationDate.difference(currentDate);
      if (timeUntilExpiration.inMinutes <= 5) {
        await saveAccessToken("");
        await saveOnce(2);

        AppUtils.showSnackBarMessage(
            "Session Expired, Login to continue", context);

        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.loginScreen,
          (route) => false,
        );
      }
    } catch (e) {
   
      await saveOnce(2);
      await saveAccessToken("");
      AppUtils.showSnackBarMessage(
          "Session Expired, Login to continue", context);
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.loginScreen,
        (route) => false,
      );
    }
  }
}
