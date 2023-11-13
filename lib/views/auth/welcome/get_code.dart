import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

class GetCode extends StatefulWidget {
  const GetCode({Key? key}) : super(key: key);

  @override
  _GetCodeState createState() => _GetCodeState();
}

class _GetCodeState extends State<GetCode> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.light // dark text for status bar
        ));
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Pallete.onboardColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(children: [
                  Image.asset(AppImages.banner),
                  Positioned(
                    left: _getSize.width * 0.1,
                    bottom: _getSize.height * 0.15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No Access Code',
                          style: AppFonts.boldText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Pallete.primaryColor,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: _getSize.height * 0.003,
                        ),
                        SizedBox(
                          width: _getSize.width * 0.7,
                          child: Text(
                            'Not to worry, provide the information below and our support agent will contact you.',
                            maxLines: 2,
                            style: AppFonts.bodyText.copyWith(
                                fontWeight: FontWeight.w300,
                                color: Pallete.whiteColor,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInput3(
                        label: 'Email or Phone',
                        hint: 'Enter Address or Phone Number',
                        onSaved: (value) {},
                      ),
                      SizedBox(
                        height: _getSize.height * 0.03,
                      ),
                      CustomInput3(
                        label: 'Email or Phone',
                        hint: 'Your Location',
                        onSaved: (value) {},
                      ),
                      SizedBox(
                        height: _getSize.height * 0.05,
                      ),
                      ButtonWithFuction(
                          text: "Continue",
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.getCodeResScreen);
                          }),
                      SizedBox(
                        height: _getSize.height * 0.3,
                      ),
                      // Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Container(
                      //           color: Pallete.fade,
                      //           width: _getSize.width * 0.17,
                      //           height: _getSize.height * 0.0005,
                      //         ),
                      //         const Text("  Don't have a code tenant? "),
                      //         Container(
                      //           color: Pallete.fade,
                      //           width: _getSize.width * 0.17,
                      //           height: _getSize.height * 0.0005,
                      //         ),
                      //       ],
                      //     ),
                      //     SizedBox(
                      //       height: _getSize.height * 0.03,
                      //     ),
                      //     Text(
                      //       "Contact Abja properties",
                      //       style: AppFonts.body1.copyWith(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w600,
                      //           color: Pallete.text),
                      //     ), SizedBox(
                      //       height: _getSize.height * 0.02,
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 8.0, horizontal: 16),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         children: [
                      //           Image.asset(
                      //             AppImages.inbox,
                      //             width: _getSize.width * 0.05,
                      //           ),
                      //           Image.asset(
                      //             AppImages.support,
                      //             width: _getSize.width * 0.05,
                      //           ),

                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(height: _getSize.height * 0.02),
                      //     Row(
                      //       children: [
                      //         Container(
                      //           color: Pallete.fade,
                      //          width: _getSize.width * 0.38,
                      //           height: _getSize.height * 0.0005,
                      //         ),
                      //         const Text("  Or  "),
                      //         Container(
                      //           color: Pallete.fade,
                      //          width: _getSize.width * 0.38,
                      //           height: _getSize.height * 0.0005,
                      //         ),
                      //       ],
                      //     )
                      //   ],
                      // ),
                      // SizedBox(height: _getSize.height * 0.02),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.welcomeScreen)
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Do you have an access code?',
                                  style: AppFonts.bodyText.copyWith(
                                      color: Pallete.fade,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                SizedBox(height: _getSize.height * 0.02),
                                Text(
                                  '  Click here',
                                  style: AppFonts.boldText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Pallete.secondaryColor,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _getSize.height*0.035,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:40.0),
                            child: Image.asset(
                              AppImages.chat,
                              width: _getSize.width*0.15,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
