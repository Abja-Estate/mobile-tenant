import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../components/buttons.dart';
import '../../../components/input_field.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

class ConfirmLandlord extends StatefulWidget {
  const ConfirmLandlord({Key? key}) : super(key: key);

  @override
  _ConfirmLandlordState createState() => _ConfirmLandlordState();
}

class _ConfirmLandlordState extends State<ConfirmLandlord> {
  String name = '';
  var photo = 'https://picsum.photos/200';

  bool loading = false;

  initLandlord() async {
    loading = false;
    await Future.delayed(Duration(seconds: 1));
    landlord;
    loading = true;
    setState(() {});
  }

  Map<String, dynamic> landlord = {};
  @override
  void initState() {
    initLandlord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.light // dark text for status bar
        ));
    final _getSize = MediaQuery.of(context).size;
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    landlord = dataFromRoute["data"];
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
                          'Confirm your Landlord',
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
                            'Confirm that the individual is your landlord.',
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
                SizedBox(
                  height: _getSize.height * 0.1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      loading
                          ? Container(
                              width: _getSize.width * 0.8,
                              height: _getSize.height * 0.08,
                              decoration: const BoxDecoration(
                                  color: Pallete.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(29, 134, 130, 130),
                                      blurRadius: 11,
                                      spreadRadius: 1,
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: _getSize.width * 0.03,
                                    ),
                                    ClipOval(
                                      child: Image.network(
                                        landlord["landlordSelfie"],
                                        fit: BoxFit.cover,
                                        width: _getSize.width * 0.14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: _getSize.width * 0.05,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Landlord",
                                          style: AppFonts.bodyText.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: _getSize.height * 0.003,
                                        ),
                                        SizedBox(
                                                   width: _getSize.width*0.45,
                                          child: Text(landlord["fullName"],
                                              style: AppFonts.body1.copyWith(
                                                  color: Pallete.text,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        SizedBox(
                                          height: _getSize.height * 0.003,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppImages.location,
                                              width: 14,
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            SizedBox(
                                              width: _getSize.width*0.45,
                                              child: Text(
                                                landlord["location"],
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFonts.body1.copyWith(
                                                    color: Pallete.text),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SpinKitRing(
                              size: 30,
                              color: Pallete.primaryColor,
                              lineWidth: 2.0,
                            ),
                      SizedBox(
                        height: _getSize.height * 0.3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.welcomeScreen);
                            },
                            child: Container(
                              width: _getSize.width * 0.4,
                              height: _getSize.height * 0.06,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: Pallete.primaryColor, width: 0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              child: Center(
                                  child: Text(
                                "Cancel",
                                style: AppFonts.body1.copyWith(fontSize: 18),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: _getSize.width * 0.4,
                            child: ButtonWithFuction(
                                text: "Proceed",
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.registerScreen);
                                }),
                          ),
                        ],
                      ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
