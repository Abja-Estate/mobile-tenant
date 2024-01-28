import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImagePopUp extends StatelessWidget {
  const ImagePopUp({Key? key, required this.img}) : super(key: key);
  final String img;
  @override
  Widget build(BuildContext context) {
    final getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0x1F000000),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(239, 225, 226, 225),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: getSize.height*0.4,
                  width: getSize.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      img != null
                          ? Image.network(img,width: getSize.width * 0.9,height: getSize.height*0.4,fit: BoxFit.contain,)
                          : SpinKitRing(
                              size: 40,
                              lineWidth: 2.5,
                              color: Pallete.primaryColor,
                            ),
                    ],
                  )),
            ]),
      ),
    );
  }
}
