import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppFonts {
  static TextStyle boldTextPrimary = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 18,
      color: Pallete.primaryColor,
      fontWeight: FontWeight.w700,
    ),
  );

    static TextStyle bodyThinColoured = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      color: Pallete.primaryColor,
    ),
  );
  static TextStyle coloredHeading = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Pallete.primaryColor,
    ),
  );
  static TextStyle labelStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Pallete.primaryColor,
    ),
  );
  static TextStyle errorStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 12,
      backgroundColor: Colors.transparent,
    ),
  );
   static TextStyle dialogColoredText = GoogleFonts.nunito(
    textStyle: const TextStyle(
      color: Color(0xFF007AFF),
      fontSize: 17,
    ),
  );
  static TextStyle bodyText = GoogleFonts.nunito(
    textStyle: const TextStyle(
      fontSize: 12,
      color: Pallete.fade,
      fontWeight: FontWeight.w300,
    ),
  );
 static TextStyle boldText = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Pallete.text,
    ),
  );
    static TextStyle hintStyle =GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(0, 32, 51, 0.35),
    ),
  );































  static TextStyle smallWhite = GoogleFonts.nunito(
    textStyle: const TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.w300,
    ),
  );



    static TextStyle cancel = GoogleFonts.nunito(
    textStyle: const TextStyle(
      fontSize: 12,
      color: Color(0xFFFF3737),
      fontWeight: FontWeight.w300,
    ),
  );

    static TextStyle body1 = GoogleFonts.nunitoSans(
    textStyle: const TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 146, 146, 146),
      fontWeight: FontWeight.w300,
    ),
  );
  static TextStyle headerBlack = GoogleFonts.nunito(
    textStyle: const TextStyle(
      fontSize: 18,
      color: Color.fromARGB(255, 0, 0, 0),
      fontWeight: FontWeight.bold,
    ),
  );
    static TextStyle smallWhiteBold = GoogleFonts.nunito(
    textStyle: const TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.bold,
    ),
  );
}
