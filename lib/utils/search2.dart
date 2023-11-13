import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';


class Search2 extends StatelessWidget {
  const Search2(
      {required this.icon, required this.text,  this.colors});
  final Widget text;
  final Widget icon;
  final Color? colors;
  @override
  Widget build(BuildContext context) {
    return Container(
     
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Pallete.whiteColor,
            ),
            child: text,
          ),
        ],
      ),
    );
  }
}





class Search3 extends StatelessWidget {
  const Search3(
      {required this.icon, required this.text});
  final Widget text;
  final Widget icon;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Pallete.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:0.0,bottom: 0.0,left:8.0),
                  child: text,
                ),
              ],
            ),
          ),SizedBox(
            width: 8.0,
          ),
          SizedBox(width: 20, height: 25, child: icon),
         
        ],
      ),
    );
  }
}
