import 'package:flutter/material.dart';

import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';


class ValidationTextRow extends StatelessWidget {
  const ValidationTextRow({
    Key? key,
    required this.text,
    required this.passed,
  }) : super(key: key);

  final String text;
  final bool passed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            passed ? AppImages.greenMark : AppImages.mark,
            fit: BoxFit.cover,
            width: 14,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: AppFonts.body1.copyWith(
              color: passed ? const Color(0xFF56C568) : const Color(0xFF959595),
            ),
          ),
        ],
      ),
    );
  }
}
