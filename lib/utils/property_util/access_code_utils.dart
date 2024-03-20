import 'package:abjatenant/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class AccessCodeUtil {
  static Future<String> accessCode(
      GlobalKey<FormState> formkey, BuildContext context, String code) async {
    // print(code);

    var result;

    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      Provider.of<PropertyProvider>(context, listen: false)
          .accessCode(code)
          .then((value) async {
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
          formkey.currentState!.reset();

          await saveAccessCode(code);
          await saveUnitData(value['data']['data']);
          await savePropertyData(value['data']);

          // await setSecured(value['data']['status']);
          Navigator.of(context).pushNamed(
            AppRoutes.confirmLandlordScreen,
            arguments: {
              'data': value['data'],
              'isRegistered': value['data']['isRegistered']
            },
          );
          // Navigator.of(context)
          // .popAndPushNamed(AppRoutes.confirmLandlordScreen);
        } else {
          AppUtils.singleDialog(
              context,
              "Oops",
              value['error'],
              'Close',
              const Icon(Icons.error_rounded),
              const Text(""),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreen, (route) => false));
        }
      });
    }

    return result;
  }

  static Future<String> isDeleted(BuildContext context) async {
    // print(code);

    var result;

    var code = await showuuId();

    print(code);

    Provider.of<PropertyProvider>(context, listen: false)
        .accessCode(code)
        .then((value) async {
      if (value['statusCode'] == 200 || value['statusCode'] == 202) {
        print("heere");
      } else {
        AppUtils.showAlertDialog(
            context,
            value['error'],
            'This unit no longer exist',
            'Contact Landlord',
            'Close',
            () => Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen, (route) => false));

        Future.delayed(Duration(seconds: 2), () async {
          await clear();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
        });
      }
    });

    return result;
  }
}
