import 'dart:ffi';
import 'package:abjatenant/views/auth/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/buttons.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../navbar/nav.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isChecked = false;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent * _scrollThreshold &&
        !_scrollController.position.outOfRange) {
      print('Scroll position is at ${_scrollThreshold * 100}%.');
    }
  }

  static const _itemCount = 32;
  static const _scrollThreshold = 1.00;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    isChecked;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppImages.back,
                        width: 36,
                      ),
                      Text("")
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Container(
                  width: _getSize.width,
                  height: _getSize.height * 0.05,
                  color: Color(0xFF47893F),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Before you can proceed you must read and agree to Abja ",
                        style: AppFonts.smallWhite.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Property Management Terms and Conditions.",
                          style: AppFonts.smallWhite.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 14))
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Abja Property Management",
                      style: AppFonts.boldText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Pallete.primaryColor),
                    ),
                    Text(
                      "Terms and Conditions",
                      style: AppFonts.boldText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Pallete.primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Image.asset(
                  AppImages.rules,
                  width: _getSize.width * 0.2,
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Last Updated: ",
                        style: AppFonts.bodyText.copyWith(fontSize: 14),
                      ),
                      Text(
                        "November, 2023",
                        style: AppFonts.bodyText,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.01,
                ),
                SizedBox(
                    height: _getSize.height * 0.45,
                    child: Center(
                        child: ListView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: 1,
                            itemBuilder: (BuildContext ctx, int index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          "These Terms and Conditions governs your use of the Abja Property Management Mobile App made available by Transform Africa Limited. By using the App, you agree to be bound by these Terms. The App is only available to individuals who are 18 years of age or older and who have a valid email address. In order to use the Abja Property Management App, you must create an account. When creating an account, you must provide accurate and up-to-date information. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your  You may use the App to manage your properties, including but not limited to: Creating and managing tenant leases Collecting rent payments Tracking maintenance requests Managing property expensesYou agree not to use the App for any illegal or prohibited purpose. You also agree not to interfere with the operation of the App or to violate the rights of any other user of the App.The Company may terminate your access to the App at any time for any reason. You may also terminate your use of the App at any time.The Company makes no representations or warranties about the App, including but not limited to its accuracy, completeness, or timeliness. The Company also disclaims any liability for any damages that you may suffer as a result of using the App.These Terms are governed by the laws of the country of Uganda. Any disputes arising out of these Terms will be resolved in the courts of the country.These Terms constitute the entire agreement between you and the Company regarding the Abja Property Management App. These Terms supersede any prior or contemporaneous communications, representations, or agreements, whether oral or written."),
                                      SizedBox(
                                        height: _getSize.height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                            activeColor: Pallete.primaryColor,
                                            value: isChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isChecked = !isChecked;
                                                print(isChecked);
                                              });
                                            },
                                          ),
                                          Text(
                                            "I accept the above terms and conditions.",
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )))),
                Column(
                  children: [
                    Container(
                      height: _getSize.height * 0.0008,
                      decoration: BoxDecoration(
                          color: Pallete.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5))),
                    ),
                    Container(
                      height: _getSize.height * 0.2,
                      width: _getSize.width,
                      child: SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Scroll to the bottom",
                              style: AppFonts.boldText.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: _getSize.height * 0.02,
                            ),
                            ButtonWithFuction(
                                text: 'I agree',
                                disabled: false,
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NavBar(initialScreen: Welcome(),initialTab: 0,)),
                                    (route) => false,
                                  );
                                }),
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class plan extends StatelessWidget {
  const plan(
      {super.key,
      required this.type,
      required this.period,
      required this.color,
      required this.bColor,
      required this.size,
      this.textColor,
      this.textColor2,
      required this.bxsize});
  final String type;
  final String period;
  final Color color;
  final double size;
  final Color bColor;
  final Color? textColor;
  final Color? textColor2;
  final double bxsize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: bxsize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
          border: Border.all(color: bColor, width: 0.7)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            Text(
              type,
              style: AppFonts.body1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Pallete.fade),
            ),
            SizedBox(
              height: size,
            ),
            Text(
              period,
              style: AppFonts.body1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: textColor2 ?? Pallete.fade),
            )
          ],
        ),
      ),
    );
  }
}

class props extends StatelessWidget {
  const props(
      {super.key, required this.type, required this.check, required this.onch});
  final String type;
  final bool check;
  final Function(bool?) onch;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              activeColor: Pallete.primaryColor, value: check, onChanged: onch),
          Text(
            type,
            style: AppFonts.body1.copyWith(
                color: Pallete.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
