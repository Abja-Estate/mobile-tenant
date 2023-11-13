import 'package:flutter/material.dart';
import '../components/buttons.dart';
import '../components/input_field.dart';
import '../constants/app_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import 'auth_utils/update_userdata_utils.dart';


class LoaderPhone extends StatelessWidget {
   LoaderPhone({Key? key}) : super(key: key);
  final _updateFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> _updateData = {
    'phone': '',
  };
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0x1F000000),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:   [

              Column(
                    children: [
                      Form(
                        key: _updateFormKey,
                        child: Column(
                          children: [
                            CustomInput2(
                              label: 'Phone',
                              hint: 'Enter Phone number',
                              onSaved: (value) {
                                _updateData['phone'] = value;
                              },
                             
                            ),
                         
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.0001,
                      ),

               ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //this is the submit button
                      ButtonWithFuction(
                          text: 'update',
                          onPressed: () {
                          
                           UpdateUtil.update(_updateFormKey, context, _updateData);
                          }),
                      SizedBox(
                        height: 16,
                      ),
                   ],
                  ),
               
          
         ]
      ),
    );
  }
}