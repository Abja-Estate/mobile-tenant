
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';

class Entrance extends StatefulWidget {
  const Entrance({Key? key}) : super(key: key);

  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF6F9F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImages.entrance),
                SizedBox(height: _getSize.height * 0.2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to ABJA',
                      style: AppFonts.boldTextPrimary
                          .copyWith(color: Color(0xFF47893F)),
                    ),
                    SizedBox(height: _getSize.height * 0.01),
                    SizedBox(
                        width: _getSize.width * 0.7,
                        child: Text(
                          'Your one-stop shop for all your property management needs.',
                          style: AppFonts.bodyText
                              .copyWith(fontSize: 14, color: Pallete.text),
                        )),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.onboarding);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Pallete.primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 32),
                          child: Text(
                            'Get Started',
                            style:
                                AppFonts.smallWhiteBold.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
