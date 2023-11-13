
import 'package:flutter/material.dart';

import '../../../../../constants/app_fonts.dart';
import '../../../../../constants/app_images.dart';
import '../../../constants/app_colors.dart';


class PrivacyInfo extends StatelessWidget {
  const PrivacyInfo({
    Key? key,
    this.mainAxisAlignment,
  }) : super(key: key);

  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.privacy,
          fit: BoxFit.cover,
          width: 14,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Your information is protected by our ',
          style: AppFonts.body1.copyWith(
            color: const Color(0xFF959595),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'privacy policy',
            style: AppFonts.body1.copyWith(
                color: Pallete.primaryColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
