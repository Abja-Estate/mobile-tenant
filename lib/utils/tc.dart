import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

import '../constants/app_fonts.dart';
import '../constants/app_routes.dart';

class LoginNavigation extends StatelessWidget {
  const LoginNavigation({Key? key, required this.text, required this.text2, required this.dir})
      : super(key: key);
  final String text;
  final String text2;
  final String dir;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text2,
              style: AppFonts.bodyText.copyWith(
                color: Pallete.text,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacementNamed(dir),
              child: Text(
                text,
                style: AppFonts.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Pallete.secondaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
