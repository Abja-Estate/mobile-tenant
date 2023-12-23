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
        print(value);
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
          // formkey.currentState!.reset();

           await saveAccessCode(code);
          saveUnitData(value['data']['data'].toString());
              
          // await setSecured(value['data']['status']);
          Navigator.of(context).pushNamed(
            AppRoutes.confirmLandlordScreen,
            arguments: {'data': value['data']},
          );
          // Navigator.of(context)
          // .popAndPushNamed(AppRoutes.confirmLandlordScreen);
        } else {
         

          
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Contact Support',
                'Close',
                () =>
                    Navigator.of(context).pop());
          
        }
      });
    }

    return result;
  }
}
