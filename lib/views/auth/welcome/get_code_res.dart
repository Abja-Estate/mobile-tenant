import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

class GetCodeResponse extends StatefulWidget {
  const GetCodeResponse({Key? key}) : super(key: key);

  @override
  _GetCodeResponseState createState() => _GetCodeResponseState();
}

class _GetCodeResponseState extends State<GetCodeResponse> {
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
                ]), Image.asset(
                              AppImages.bags,
                              width: _getSize.width * 0.55,
                            ), SizedBox(
                        height: _getSize.height * 0.05,
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Thank You for Choosing Abja property",style: AppFonts.body1.copyWith(fontSize: 14),),
                      SizedBox(
                        height: _getSize.height * 0.008,
                      ),
                      Text("Management",style: AppFonts.body1.copyWith(fontSize: 14),),
                      SizedBox(
                        height: _getSize.height * 0.008,
                      ),
                     
                      Text("Our Support Agent will get back in touch",style: AppFonts.body1.copyWith(fontSize: 14),),
                      SizedBox(
                        height: _getSize.height * 0.05,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal:_getSize.width*0.2),
                        child: ButtonWithFuction(
                            text: "Back",
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.welcomeScreen);
                            }),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.1,
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

                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(""),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Image.asset(
                              AppImages.chat,
                              width: _getSize.width * 0.15,
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
