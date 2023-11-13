import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppInput {
  static const focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(
      color: Pallete.primaryColor,
    ),
  );

  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(
      color: Color.fromRGBO(0, 66, 105, 0.28),
    ),
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(
      color: Colors.red,
    ),
  );
}
