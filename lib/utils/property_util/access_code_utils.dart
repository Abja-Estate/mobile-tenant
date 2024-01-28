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
            arguments: {'data': value['data'],'isRegistered':value['data']['isRegistered']},
          );
          // Navigator.of(context)
          // .popAndPushNamed(AppRoutes.confirmLandlordScreen);
        } else {
          AppUtils.showAlertDialog(
              context,
            value['error'],
              'Another tenant has already loaded into this unit.',
              'Contact Landlord',
              'Close',
              () => Navigator.of(context).pop());
        }
      });
    }

    return result;
  }
}
