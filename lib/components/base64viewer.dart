import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class Base64Image extends StatelessWidget {
  final String base64String;
  final double width;
  final double height;

  const Base64Image(
      {required this.base64String, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(
      bytes,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}

class Base64ImageContainer extends StatelessWidget {
  final String base64String;
  final double width;
  final double height;

  const Base64ImageContainer({
    required this.base64String,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);
    ImageProvider imageProvider = MemoryImage(bytes);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Base64ImageContainer2 extends StatelessWidget {
  final String base64String;
  final double width;
  final double height;

  const Base64ImageContainer2({
    required this.base64String,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);
    ImageProvider imageProvider = MemoryImage(bytes);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Base64ImageCartImage extends StatelessWidget {
  final String base64String;
  final Widget item;

  const Base64ImageCartImage({
    required this.base64String,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);
    ImageProvider imageProvider = MemoryImage(bytes);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: item,
    );
  }
}
