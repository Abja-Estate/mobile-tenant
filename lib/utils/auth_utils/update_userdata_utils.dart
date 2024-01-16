import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class UpdateUtil {
  static Future<String> update(GlobalKey<FormState> formkey,
      BuildContext context, Map<String, dynamic> updateData) async {
     print(updateData);


    var result;

    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      Provider.of<AuthProvider>(context, listen: false)
          .update(
              updateData['email'],
              updateData['phone'],
              updateData['password'],
              updateData['confirmPassword'],
              updateData['name'],
              updateData['surname'],
              updateData['about'],  updateData['selfie']
             )
          .then((value) async {
        print(value);
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
       
         
          await saveEmail(value['data']['email']);
          await saveName(value['data']['name']);
          await savePhone(value['data']['phone']);
          await saveSurname(value['data']['surname']);
          await saveSelfie(value['data']['selfie']);
          await saveAbout(value['data']['about'] ?? "");
     
      // ignore: use_build_context_synchronously
      AppUtils.SuccessDialog(
              context,
              "Successful",
              "Your Profile has been updated successfully",
              Image.asset(
                AppImages.success,
                width: 48,
              ),
              "back",
              AppRoutes.profile);
         // Navigator.of(context).popAndPushNamed(AppRoutes.dashboardScreen);
        } else {
          
        }
      });
    }

    return result;
  }
}
