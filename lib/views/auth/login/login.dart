import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

import '../../../utils/auth_utils/login_utils.dart';
import '../../../utils/notification_util.dart';
import '../../../utils/tc.dart';
import '../../../utils/validator.dart';
import '../register/register.dart';
import 'validation_text_row.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false;
  bool passwordVisible = false;

  final _loginFormKey = GlobalKey<FormState>();
  bool obsecure = true;
  var name = "Solomon";
  bool enabled = false;
  bool isSpecialAdded = false;
  bool isNumAdded = false;
  bool isAboveEight = false;



  void _checkPasswordStrength(String value) {
    dynamic password = value.trim();
    setState(() {
      if (Validators.numReg.hasMatch(password)) {
        // Password has number
        isNumAdded = true;
      } else {
        isNumAdded = false;
      }
      if (password.length > 8) {
        // Password is more than 8
        isAboveEight = true;
      } else {
        isAboveEight = false;
      }
      if (isNumAdded && isAboveEight) {
        enabled = true;
      } else {
        enabled = false;
      }
    });
  }

  final Map<String, dynamic> _loginData = {
    'email': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
  }

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
                        'Login',
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
                            'Fill in the details below to login your ',
                            style: AppFonts.bodyText.copyWith(
                              color: Pallete.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Abja Property',
                              style: AppFonts.body1.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Pallete.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' Management ',
                            style: AppFonts.bodyText.copyWith(
                              color: Pallete.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'account',
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
              child: Column(
                children: [
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        CustomInput3(
                          validator: Validators.nameValidator,
                          label: 'Phone Number or Email',
                          hint: 'Phone Number or Email',
                          onSaved: (value) {
                            _loginData['email'] = value;
                          },
                        ),
                        SizedBox(
                          height: _getSize.height * 0.05,
                        ),
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
                          hint: 'Password',
                          onChanged: (String? value) {},
                          onSaved: (value) {
                            _loginData['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: _getSize.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _getSize.height * 0.01),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Password? ",
                    style: AppFonts.body1.copyWith(
                        color: Pallete.text, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Tap here",
                    style:
                        AppFonts.body1.copyWith(color: Pallete.secondaryColor),
                  )
                ],
              ),
            ),
            SizedBox(height: _getSize.height * 0.15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  child: ButtonWithFuction(
                      text: 'Login',
                      onPressed: () {
                        LoginUtil.login(_loginFormKey, context, _loginData);
                      }),
                ),
                SizedBox(height: _getSize.height * 0.01),
                const LoginNavigation(
                  text2: "Don'\t have an account? ",
                  text: 'Sign Up',
                  dir: AppRoutes.welcomeScreen,
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
