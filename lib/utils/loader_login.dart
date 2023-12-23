import 'package:flutter/material.dart';
import '../constants/app_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_colors.dart';


class LoginLoader extends StatelessWidget {
  const LoginLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0x1F000000),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:   [
            Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(239, 225, 226, 225),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 175,width:MediaQuery.of(context).size.width*0.7,
              child:Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitRing(size: 40,lineWidth: 2.5, color: Pallete.primaryColor,),
                  SizedBox(height: 16,),
                  SizedBox(width: MediaQuery.of(context).size.width*0.5,
                    child: Text('Please hold on while the system fetches the unit information',textAlign: TextAlign.center, style: AppFonts.bodyText.copyWith(fontSize: 14,color: Pallete.text,fontWeight: FontWeight.w600),)),
                 
                ],
              )),]
        ),
      ),
    );
  }
}