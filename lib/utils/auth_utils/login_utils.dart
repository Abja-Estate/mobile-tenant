import 'package:abjatenant/network/property.dart';
import 'package:abjatenant/utils/property_util/access_code_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class LoginUtil {
  static Future<String> login(GlobalKey<FormState> formkey,
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
        loginData['email'].trim(),
        loginData['password'].trim(),
      )
          .then((value) async {
        print(value);
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
          print("yes ${value}");
          // formkey.currentState!.reset();
          await saveId(value['data']['_id'].toString());
          await saveEmail(value['data']['email']);
          await saveName(value['data']['name']);
          await savePhone(value['data']['phone']);
          await saveSurname(value['data']['surname']);
          await saveSelfie(value['data']['selfie'] ??
              "https://i.ibb.co/txwfp3w/37f70b1b79e6.jpg");
          await saveToken(value['data']['accessTken'] ?? "");
          await saveAbout(value['data']['about'] ?? "");
          await saveOnce(3);
          AppUtils.showLoginLoader(context);

          var responseData = await PropertyAPI.accessCode(
              value['data']['rentHistory'][0]['accessCode']);

          if (responseData['statusCode'] == 200) {
            await saveAccessCode(value['data']['rentHistory'][0]['accessCode']);
            await saveUnitData(responseData['data']);
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.navbar, // The route name of the new screen
              (Route<dynamic> route) =>
                  false, // Predicate to remove all previous routes
            );
          }
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
          if (value['statusCode'] == 400) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Enter OTP',
                'Close',
                () => Navigator.of(context)
                    .pushNamed(AppRoutes.registerOTPScreen));
          }
          if (value['statusCode'] == 400 &&value['validated'] == false ) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Enter OTP',
                'Close',
                () => Navigator.of(context)
                    .pushNamed(AppRoutes.registerOTPScreen));
          }

          if (value['statusCode'] == 403) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Contact Support',
                'Close',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.registerScreen));
          }
               if (value['statusCode'] == 500) {
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
