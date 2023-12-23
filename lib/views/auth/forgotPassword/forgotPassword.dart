import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/auth_utils/forgot_password_util.dart';
import '../../../utils/tc.dart';
import '../../../utils/validator.dart';
import 'privacy_info.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  bool enabled = false;

  final Map<String, dynamic> _resetPasswordData = {
    'email': '',
  };
  final _resetPasswordFormKey = GlobalKey<FormState>();
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
                            'Enter Email address to recieve one-time-password',
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
                      key: _resetPasswordFormKey,
                    child: Column(
                      children: [
                        CustomInput3(
                          validator: Validators.nameValidator,
                          label: 'Email',
                          hint: 'Email',
                          onChanged: (value) {
                            print(value);
                            _resetPasswordData['email'] = value;
                          },
                          onSaved: (value) {
                            print(value);
                            _resetPasswordData['email'] = value;
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
            SizedBox(height: _getSize.height * 0.15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  child: ButtonWithFuction(
                      text: 'Get OTP',
                      onPressed: () {
                        print(_resetPasswordData);
                        ForgotPasswordUtil.forgotPassword(
                            context, _resetPasswordData);
                        // Navigator.of(context).pushNamed(AppRoutes.resetOTPScreen);
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
