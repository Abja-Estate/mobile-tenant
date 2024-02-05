import 'package:abjatenant/network/property.dart';
import 'package:abjatenant/utils/property_util/access_code_utils.dart';
import 'package:abjatenant/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../provider/property_provider.dart';
import '../../views/navbar/nav.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class SwitchAccountUtil {
  static Future<String> switchAcc(
      BuildContext context, String accessCode) async {
    // print(loginData);
    //var token2 = await showToken();
    //var id2 = await showId();

    var result;
    var email = await showEmail();

    AppUtils.showLoader(context);
    Provider.of<PropertyProvider>(context, listen: false)
        .switchAccount(
      accessCode,
      email,
    )
        .then((value) async {
      print(value);
      Navigator.of(context).pop();

      if (value['statusCode'] == 200) {
        AppUtils.showLoginLoader(context);

        await saveOnce(3);
        var responseData = value;
        await saveAccessCode(responseData['data']['data']['unitID']);
        await saveUnitData(responseData['data']['data']);
        await savePropertyData(responseData['data']);
        await saveuuId(responseData['data']['data']['unitID']);
        await saveOnce(3);
        Provider.of<PropertyProvider>(context, listen: false)
            .getPropertyItems();
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.loadAccount, (route) => false);
      } else {}
    });

    return result;
  }
}

class ProviderProvider {}
