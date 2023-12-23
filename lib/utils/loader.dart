import 'package:flutter/material.dart';
import '../constants/app_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_colors.dart';


class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: 175,width: 275,
            child:Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitRing(size: 50,lineWidth: 2.5, color: Pallete.primaryColor,),
               
              ],
            )),]
      ),
    );
  }
}