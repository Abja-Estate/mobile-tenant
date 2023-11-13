import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:abjatenant/constants/app_images.dart';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({ Key? key }) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
  // Navigate to a new page
  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.navbar, (route) => false);
});

  }
  @override
  Widget build(BuildContext context) {
     final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SafeArea(child: 
      SingleChildScrollView(
        child: SizedBox(
          height: _getSize.height,
          child: Center(
               child:   Column(crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(AppImages.success),
          SizedBox(height: _getSize.height*0.04,),
          SizedBox(width: _getSize.width*0.7,
            child: Text('Your request has been successfully sent to the landlord',textAlign: TextAlign.center, style: AppFonts.bodyText.copyWith(fontSize: 18),))
               ],)
          ),
        ),
      )),
      
    );
  }
}