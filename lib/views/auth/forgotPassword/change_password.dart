import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';

import '../../../constants/app_routes.dart';
import '../../../utils/auth_utils/change_password_util.dart';
import '../../../utils/validator.dart';
import '../login/validation_text_row.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool obsecure = true;
  bool enabled = false;
  bool isLetterAdded = false;
  bool isNumAdded = false;
  bool isAboveEight = false;

  String password = "";
    String cPassword = "";

  void _checkPasswordStrength(String value) {
    dynamic password = value.trim();
    setState(() {
      if (Validators.numReg.hasMatch(password)) {
        // Password has number
        isNumAdded = true;
      } else {
        isNumAdded = false;
      }
      if (Validators.lettersmallReg.hasMatch(password) &&
          Validators.letterReg.hasMatch(password)) {
        // Password has number
        isLetterAdded = true;
      } else {
        isLetterAdded = false;
      }
      if (password.length > 8) {
        // Password is more than 8
        isAboveEight = true;
      } else {
        isAboveEight = false;
      }
      if (isLetterAdded && isNumAdded && isAboveEight) {
        enabled = true;
      } else {
        enabled = false;
      }
    });
  }

  bool isSpecialAdded = false;

  String confirmPassword = '';
  final _resetFormKey = GlobalKey<FormState>();
  bool value = false;
  bool passwordVisible = false;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(AppImages.banner),
                Positioned(
                  left: _getSize.width * 0.1,
                  bottom: _getSize.height * 0.13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reset Password',
                        style: AppFonts.bodyText.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Pallete.primaryColor,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter new password',
                            style: AppFonts.bodyText.copyWith(
                              color: Pallete.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              child: Form(
                key: _resetFormKey,
                child: Column(
                  children: [
                    CustomInput3(
                      validator: Validators.passwordValidator,
                      obsecure: !passwordVisible,
                      suffixIcon: IconButton(
                          onPressed: () {
                            //call set state so that the UI is rebuilt on click
                            setState(() {
                              //loop through either state when clicked
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            // if password visibilty is default false set icon to visible icon or else set to hide icon
                            passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off,
                            color: Pallete.fade, size: 18,
                          )),
                      label: 'Password',
                      hint: 'New Password',
                      onChanged: (String? value) {
                        confirmPassword = value!;
                      },
                      onSaved: (value) {
                      password = value!;
                      },
                    ),
                    SizedBox(
                      height: _getSize.height * 0.05,
                    ),
                    CustomInput3(
                      obsecure: !passwordVisible,
                      suffixIcon: IconButton(
                          onPressed: () {
                            //call set state so that the UI is rebuilt on click
                            setState(() {
                              //loop through either state when clicked
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            // if password visibilty is default false set icon to visible icon or else set to hide icon
                            passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off,
                            color: Pallete.fade, size: 18,
                          )),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Confirm password cannot be empty';
                        }
                        if (value != confirmPassword) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      label: 'Confirm Password',
                      hint: 'Confirm Password',
                      onSaved: (value) {
                        cPassword = value!;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: _getSize.height * 0.01),
            SizedBox(height: _getSize.height * 0.15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  child: ButtonWithFuction(
                      text: 'Submit',
                      onPressed: () {
                        ResetPasswordUtil.resetPassword(
                            _resetFormKey, context, password, cPassword);
                        // Navigator.of(context).pushNamed(AppRoutes.loginScreen);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
