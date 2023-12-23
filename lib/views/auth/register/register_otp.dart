import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../../components/buttons.dart';
import '../../../components/pinbox.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../utils/auth_utils/otp_util.dart';
import '../../../utils/auth_utils/retry_otp_util.dart';

class RegisterOTPScreen extends StatefulWidget {
  RegisterOTPScreen({Key? key}) : super(key: key);

  @override
  State<RegisterOTPScreen> createState() => _RegisterOTPScreenState();
}

class _RegisterOTPScreenState extends State<RegisterOTPScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  bool hasError = false;
  String currentText = "";

  String otp = '';


  bool value = false;
  bool passwordVisible = false;


  final focusNode = FocusNode();

   Duration _duration = Duration(minutes: 4);
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        timer.cancel();
        onTimerComplete();
      } else {
        setState(() {
          _duration -= Duration(seconds: 1);
        });
      }
    });
  }

  void onTimerComplete() {
    // Function to handle logic when timer completes
   Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginScreen, (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  void initState() {
     startTimer();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));

    final _getSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
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
                            'OTP Verification',
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
                                'We have sent a code to your registered email and phone number',
                                style: AppFonts.bodyText.copyWith(
                                  color: Pallete.whiteColor,
                                  fontSize: 12,
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
                                'Please input the code, we have sent',
                                style: AppFonts.bodyText.copyWith(
                                  color: Pallete.whiteColor,
                                  fontSize: 12,
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
                OTPTextField(
                   
                    length: 5,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.underline,
                    outlineBorderRadius: 15,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      print("Changed: " + pin);
                       setState(() {
                        otp = pin;
                       
                      });
                    },
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    }),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              RetryOTPUtil.retry(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't get a code? ",
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.text,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Click to resend",
                                  style: AppFonts.body1
                                      .copyWith(color: Pallete.secondaryColor),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.005,
                          ),
                          Text(
                           formatDuration(_duration),
                            style: AppFonts.body1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.4,
                      ),
                      ButtonWithFuction(
                          text: "Continue",
                          onPressed: () {
                            RegisterOTPUtil.register(context, otp);
                            // Navigator.of(context)
                            //     .pushReplacementNamed(AppRoutes.loginScreen);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
    

}

String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }