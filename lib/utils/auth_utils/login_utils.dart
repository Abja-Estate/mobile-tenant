import 'package:abjatenant/network/property.dart';
import 'package:abjatenant/utils/property_util/access_code_utils.dart';
import 'package:abjatenant/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../views/navbar/nav.dart';
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
          // formkey.currentState!.reset();

          if (value['data']['rentHistory'].length == 0) {
            Navigator.of(context).pop();
            // ignore: use_build_context_synchronously
            AppUtils.singleDialog(
                context,
                'There\'s no unit attached to you',
                'Your landlord needs to assign a unit to you first',
                'Close',
                Icon(Icons.error_rounded),
                Text(""),
                () => Navigator.of(context).pushNamed(AppRoutes.welcomeScreen));
          } else {
            await saveData(value);

            AppUtils.showLoginLoader(context);

            var responseData = await callSwitch(value, loginData['email']);

            if (responseData['statusCode'] == 200) {
         
              await saveUnitData(responseData['data']['data']);
              await savePropertyData(responseData['data']);
              await saveUnitId(responseData['data']['data']['unitID']);
              await saveOnce(3);
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => NavBar(
                          initialScreen: Dashboard(),
                          initialTab: 0,
                        )),
                (route) => false,
              );
            } else {
              if (responseData['statusCode'] == 404) {
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                AppUtils.showAlertDialog(
                    context,
                    'There\'s no unit attached to you',
                    responseData['error'],
                    'Enter Code again',
                    'Close',
                    () => Navigator.of(context)
                        .pushNamed(AppRoutes.welcomeScreen));
              }
            }
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
                'Sign Up',
                'Close',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.registerScreen));
          }
          if (value['statusCode'] == 400 && value['validated'] == false) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Enter OTP',
                'Close',
                () => Navigator.of(context)
                    .pushNamed(AppRoutes.registerOTPScreen));
          }

          if (value['statusCode'] == 401) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Verify',
                'Close',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.forgotPassword));
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

saveData(value) async {
  await saveId(value['data']['_id'].toString());
       await saveRentHistory(value['data']['rentHistory']);
  await saveEmail(value['data']['email']);
  await saveName(value['data']['name']);
  await savePhone(value['data']['phone']);
  await saveSurname(value['data']['surname']);
  await saveSelfie(value['data']['selfie']);
  await saveAccessToken(value['data']['accessToken']);
  await saveAccessCode(value['data']['rentHistory'][0]['accessCode']);
  await saveAbout(value['data']['about'] ?? "");
  await saveCreatedAt(value['data']['created']);
}

callSwitch(value, email) async {
  var res = await PropertyAPI.switchAccount(
      value['data']['rentHistory'][0]['accessCode'], email.trim());

  return res;
}
