import 'dart:convert';

import 'package:abjatenant/models/tenanModel.dart';
import 'package:abjatenant/utils/local_storage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../models/unit.dart';
import '../../../network/property.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/auth_utils/register_utils.dart';
import '../../../utils/google_signup.dart';
import '../../../utils/tc.dart';
import '../../../utils/validator.dart';
import '../login/login.dart';
import '../login/validation_text_row.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obsecure = true;
  bool enabled = false;
  bool isSpecialAdded = false;
  bool isNumAdded = false;
  bool isAboveEight = false;
  String confirmPassword = '';
  final _registerFormKey = GlobalKey<FormState>();
  bool value = false;
  bool passwordVisible = false;
  String? selectedValue;

  final Map<String, dynamic> _registerData = {
    'name': '',
    'surname': '',
    'email': '',
    'phone': '',
    'password': '',
  };
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

  @override
  void initState() {
    getTenantItems();

    super.initState();
  }

  var tentInfo = {};
  getTenantItems() async {
    var tenantString = await showUnitData();
    Map<String, dynamic> jsonData = json.decode(tenantString);
    tentInfo = jsonData['tenantInfo'];
    await saveUnitId(tentInfo['unitID']);
    
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          'Sign Up',
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
                              'Fill in the details below to setup your ',
                              style: AppFonts.bodyText.copyWith(
                                color: Pallete.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'tenant profile',
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          CustomInput3(
                            enabled: false,
                            label: 'Email',
                            hint: tentInfo['email'],
                            onSaved: (value) {
                              _registerData['email'] = tentInfo['email'];
                            },
                          ),
                          SizedBox(
                            height: _getSize.height * 0.05,
                          ),
                          CustomInput3(
                            label: 'First Name',
                           
                            hint: tentInfo['name'],
                            enabled: false,
                            onSaved: (value) {
                              _registerData['name'] = tentInfo['name'];
                            },
                          ),
                          SizedBox(
                            height: _getSize.height * 0.05,
                          ),
                          CustomInput3(
                           
                            label: 'Last Name',
                            hint: tentInfo['surname'],
                            enabled: false,
                            onSaved: (value) {
                              _registerData['surname'] = tentInfo['surname'];
                            },
                          ),
                          SizedBox(
                            height: _getSize.height * 0.05,
                          ),
                          CustomInput3(
                            type: "number",
                            enabled: false,
                            label: 'Phone Number',
                            hint: tentInfo['phone'],
                            onSaved: (value) {
                              _registerData['phone'] = tentInfo['phone'];
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
                            onChanged: (String? value) {
                              confirmPassword = value!;
                            },
                            onSaved: (value) {
                              _registerData['password'] = value;
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
                            hint: 'Confirm your password',
                            onSaved: (value) {
                              //_registerData['password'] = value;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _getSize.height * 0.02),
              SizedBox(
                width: _getSize.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'By clicking "Sign Up" you agree to the ',
                          style: AppFonts.bodyText.copyWith(
                            color: Pallete.text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Terms',
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Pallete.secondaryColor),
                          ),
                        ),
                        Text(
                          ' and',
                          style: AppFonts.bodyText.copyWith(
                            color: Pallete.text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' acknowledge the ',
                          style: AppFonts.bodyText.copyWith(
                            color: Pallete.text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Privacy Policy.',
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Pallete.secondaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: _getSize.height * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16),
                    child: ButtonWithFuction(
                        text: 'Sign Up',
                        onPressed: () {
                          print(_registerData);
                          RegisterUtil.register(
                              _registerFormKey, context, _registerData);
                        }),
                  ),
                  SizedBox(height: _getSize.height * 0.01),
                  const LoginNavigation(
                    text2: "Already have an account? ",
                    text: 'Login',
                    dir: AppRoutes.loginScreen,
                  )
                ],
              ),
              SizedBox(height: _getSize.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
