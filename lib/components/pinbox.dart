import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
class PinBoxes extends StatelessWidget {
 
   PinBoxes({Key? key, required this.controller, this.onCompleted,required this.focusNode}) : super(key: key);
 
 final TextEditingController controller;
   final FocusNode focusNode;
  final String? Function(String?)? onCompleted;
    

  @override
  Widget build(BuildContext context) {
    return Pinput(
        onCompleted: onCompleted,
        
        //(String pin) => _otp['code'] = pin,
        length: 6,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: PinTheme(
        width: 55,
        height: 61,
        textStyle: GoogleFonts.poppins(
            fontSize: 20, color: const Color.fromRGBO(70, 69, 66, 1)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.black12)),
      ),
        separator: const SizedBox(width: 16),
        focusedPinTheme: PinTheme(
    
           width: 55,
        height: 61,
        textStyle: GoogleFonts.poppins(
            fontSize: 20, color: const Color.fromRGBO(70, 69, 66, 1)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                offset: Offset(0, 3),
                blurRadius: 16,
              )
            ],
          ),
        ),
        showCursor: true,
        cursor: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 24,
          height: 1,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(137, 146, 160, 1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
    );
  }
}
