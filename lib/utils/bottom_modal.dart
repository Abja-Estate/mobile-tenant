import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:abjatenant/constants/app_images.dart';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../views/navbar/nav.dart';
import '../views/request/request.dart';



class ReusableBottomSheetContent extends StatelessWidget {
  const ReusableBottomSheetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 5,
              color: Pallete.fade,
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 350,
              child: Text(
                'We’re currently reviewing your request and a notification would be sent across with payment details.',
                textAlign: TextAlign.center,
                style: AppFonts.boldText.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 310,
              child: Column(
                children: [
                  SizedBox(
                     width: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: Pallete.primaryColor,
                            ),
                          ],
                        ),
                        Container(
                          width: 170,
                          height: 2,
                          color: Pallete.primaryColor,
                        ),
                        Column(
                          children: [
                           DottedBorder(
                            color: Pallete.fade,
                             dashPattern: [3, 3, 2, 3],
  borderType: BorderType.RRect,
  radius: Radius.circular(12),
  padding: EdgeInsets.all(6),
  child: ClipOval(
   
    child: Container(
      height: 5,
      width: 5,
    
    ),
  ),)
                          ],
                        )
                      ],
                    ),
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Text("Sent"),
                    ),
                     Text("Received"),
                  ],)
                ],
              ),
            ),
            Image.asset(
              AppImages.processing,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ButtonWithFuction(
                  text: 'View ',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavBar(
                                            initialScreen: RequestScreen(),
                                            initialTab: 1,
                                          )),
                                  (route) => false,
                                );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
