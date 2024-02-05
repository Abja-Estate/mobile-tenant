import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(""),
                    const Text("Inbox"),
                    const Text("")
                  ],
                ),
              ),
             
            Center(
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
            
                children: [
                  Image.asset(
                    AppImages.no_prop,
                    width: _getSize.width * 0.6,
                  ),
                  Column(
                    children: [
                      Text(
                        "Coming Soon",
                        style: AppFonts.body1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.01,
                  ),
                ],
              ),
            ),
          SizedBox(
                height: _getSize.height * 0.04,
              ), ],
        ),
      ),
    );
  }
}
