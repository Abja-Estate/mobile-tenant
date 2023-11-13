import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';
import 'inpu_border.dart';
import 'size_config.dart';

class Field extends StatefulWidget {
  final String? hint;
  final String? error;
  final String? label;
  final String? description;
  final String? type;
  final String? value;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool? obsecure;
  final void Function(String? email)? onSaved;
  final void Function(String?)? onChanged;

  final String? Function(String?)? validator;

  final String text;
  Field({
    required this.text,
    Key? key,
    this.hint,
    this.error,
    this.label,
    this.description,
    this.value,
    this.suffixIcon,
    this.enabled,
    this.obsecure = false,
    required this.onSaved,
    this.onChanged,
    this.validator,
    this.type,
  }) : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text,
            textAlign: TextAlign.center,
            style:
                AppFonts.body1.copyWith(color: Colors.black87, fontSize: 12)),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          obscureText: widget.obsecure!,
          keyboardType: widget.type == 'number'
              ? const TextInputType.numberWithOptions(
                  signed: true, decimal: true)
              : TextInputType.emailAddress,
          maxLength: widget.type == 'number' ? 13 : 100,
          controller: controller,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          validator: widget.validator,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8, left: 8),
            suffixIcon: widget.suffixIcon,
            errorMaxLines: 1,
            counterText: '',
            filled: true,
            errorText: widget.error,
            hintStyle: AppFonts.body1,
            hintText: widget.hint,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Pallete.hintColor.withOpacity(0.2),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Pallete.primaryColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.transparent)),
            labelText: widget.label,
            labelStyle: AppFonts.body1.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class CustomTextSpan extends StatelessWidget {
  /*
  variables to hold the strings*/
  final String text;
  final String text2;
  final String text3;
  //this calls the onpressed widget
  final String onPressed;
  //this is to set color
  final Color color;
  //here we pass the sttring to the constructor
  CustomTextSpan(
    this.color,
    this.onPressed,
    this.text,
    this.text2,
    this.text3,
  );

  @override
  Widget build(BuildContext context) {
    //this class returns a Richtext widget
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: text,
              style: AppFonts.body1.copyWith(color: Pallete.text),
            ),
            TextSpan(
                text: text2,
                style: AppFonts.body1.copyWith(
                    color: Pallete.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),

                /* style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: color),*/

                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed(
                      onPressed,
                    );
                  }),
            TextSpan(
              text: text3,
              style: AppFonts.body1.copyWith(
                color: Pallete.text,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

class CustomInput extends StatelessWidget {
  final String? hint;
  final String? label;
  final String? description;
  final String? type;
  final String? value;
  final String? counter;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool? enabled;
  final Color? labelColor;
  final bool? obsecure;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomInput(
      {Key? key,
      this.hint,
      this.label,
      this.description,
      this.value,
      this.maxLines = 1,
      this.maxLength = 100,
      this.counter = '',
      this.suffixIcon,
      this.enabled = true,
      this.labelColor = Pallete.black,
      this.obsecure = false,
      required this.onSaved,
      this.onChanged,
      this.validator,
      this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: AppFonts.labelStyle.copyWith(color: labelColor),
              ),
              if (counter != '')
                Text(
                  counter!,
                  style: AppFonts.labelStyle.copyWith(color: labelColor),
                )
            ],
          ),
        SizedBox(
          height: SizeConfig.heightMultiplier! * 1,
        ),
        TextFormField(
          keyboardType: type == 'number'
              ? const TextInputType.numberWithOptions(
                  signed: true, decimal: true)
              : TextInputType.emailAddress,
          maxLength: type == 'number' ? 13 : maxLength,
          // inputFormatters: [
          //   // if (label == "Amount") ThousandsFormatter(),
          //   // if (type == 'number')
          //   //   FilteringTextInputFormatter.allow(RegExp('^[0-9,-]*\$')),
          // ],
          style: AppFonts.body1.copyWith(
              color: enabled!
                  ? Pallete.black
                  : const Color.fromRGBO(0, 32, 51, 0.35)),
          initialValue: value,
          maxLines: maxLines,
          enabled: enabled,
          obscureText: obsecure!,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            errorMaxLines: 1,
            hintText: hint,
            filled: enabled! ? false : true,
            fillColor: const Color.fromRGBO(187, 195, 201, 0.25),
            suffixIcon: suffixIcon,
            hintStyle: AppFonts.hintStyle,
            errorBorder: AppInput.errorBorder,
            errorStyle: AppFonts.errorStyle,
            counterText: '',
            focusedErrorBorder: AppInput.focusedBorder,
            focusedBorder: AppInput.focusedBorder,
            border: AppInput.border,
          ),
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
        ),
        if (description != null)
          Text(
            description!,
            style: AppFonts.body1,
          ),
      ],
    );
  }
}

class CustomInput2 extends StatelessWidget {
  final String? hint;
  final String? label;
  final String? error;
  final TextEditingController? myController;
  final String? description;
  final String? type;
  final String? value;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool? obsecure;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomInput2(
      {Key? key,
      this.hint,
      this.label,
      this.error,
      this.description,
      this.value,
      this.suffixIcon,
      this.enabled,
      this.obsecure = false,
      required this.onSaved,
      this.onChanged,
      this.validator,
      this.type, this.myController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      //maxLengthEnforced: false,
      onSaved: onSaved,
      //enabled: enabled,
      //autofocus: false,
      validator: validator,
      onChanged: onChanged,

      keyboardType: type == 'number'
          ? const TextInputType.numberWithOptions(signed: true, decimal: true)
          : TextInputType.emailAddress,
      maxLength: type == 'number' ? 13 : 100,
      // controller: passwordController,
      //  textInputAction: TextInputAction.next,
      //obscure text will hide the text
      obscureText: obsecure!,
      //enableSuggestions: false,
//autocorrect: false,
      // controller: passwordController,
//autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 2, left: 8),
        counterText: "",
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 0.5, color: Pallete.primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
                width: 0.5, color: Color.fromARGB(255, 116, 119, 121))),
        labelText: hint,
        suffixIcon: suffixIcon,
        //errorMaxLines: 1,
        errorText: error,
        hintText: hint,
        hintStyle: const TextStyle(
            color: Pallete.hintColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
        labelStyle: AppFonts.body1.copyWith(
          fontSize: 12,
          color: const Color(0xFF4F4F4F),
        ),

        //obscure text will hide the text
      ),
    );
  }
}



class CustomInput3 extends StatelessWidget {
  final String? hint;
  final String? label;
  final String? error;
  final TextEditingController? myController;
  final String? description;
  final String? type;
  final String? value;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool? obsecure;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomInput3(
      {Key? key,
      this.hint,
      this.label,
      this.error,
      this.description,
      this.value,
      this.suffixIcon,
      this.enabled,
      this.obsecure = false,
      required this.onSaved,
      this.onChanged,
      this.validator,
      this.type, this.myController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      //maxLengthEnforced: false,
      onSaved: onSaved,
      //enabled: enabled,
      //autofocus: false,
      validator: validator,
      onChanged: onChanged,

      keyboardType: type == 'number'
          ? const TextInputType.numberWithOptions(signed: true, decimal: true)
          : TextInputType.emailAddress,
      maxLength: type == 'number' ? 13 : 100,
      // controller: passwordController,
      //  textInputAction: TextInputAction.next,
      //obscure text will hide the text
      obscureText: obsecure!,
      //enableSuggestions: false,
//autocorrect: false,
      // controller: passwordController,
//autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 2, left: 8),
        counterText: "",
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 0.5, color: Pallete.primaryColor)),
        enabledBorder: UnderlineInputBorder( borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 0.5, color: Pallete.primaryColor)),
        labelText: hint,
        suffixIcon: suffixIcon,
        //errorMaxLines: 1,
        errorText: error,
        hintText: hint,
        hintStyle: const TextStyle(
            color: Pallete.hintColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
        labelStyle: AppFonts.body1.copyWith(
          fontSize: 12,
          color: const Color(0xFF4F4F4F),
        ),

        //obscure text will hide the text
      ),
    );
  }
}
