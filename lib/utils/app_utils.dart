import 'dart:io';
//import 'package:cashflakes/views/screens/dashboard/transfer/components/pay_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

import 'package:uuid/uuid.dart';

import '../constants/app_routes.dart';
import 'loader.dart';

class AppUtils {
  static dynamic payAlertDialog(
    BuildContext context,
    String titleText,
    String contentText,
    String price,
      String contentText2,
    String confirmText,
    String cancelText,
    Map<String,dynamic> urlGotten,
  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        cancelText,
        style: AppFonts.dialogColoredText
            .copyWith(color: Pallete.text, fontSize: 12),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget confirmButton = TextButton(
        child: Text(
          confirmText,
          style: AppFonts.dialogColoredText.copyWith(
              fontWeight: FontWeight.w600, color: Pallete.primaryColor),
        ),
        onPressed: () => Navigator.of(context)
            .pushNamed(arguments: {"data": urlGotten}, AppRoutes.webviewScreen));

    // title
    Widget title = Center(
      child: Text(
        titleText,
        style: AppFonts.dialogColoredText.copyWith(
          fontWeight: FontWeight.w600,
          color: Pallete.primaryColor,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );

    // content
    Widget content = Row(
      children: [
        Text(
          contentText,
          style: AppFonts.body1.copyWith(fontSize: 13),
          textAlign: TextAlign.center,
        ),
          Text(
          price,
          style: AppFonts.boldText.copyWith(color: Pallete.black,fontSize: 14,fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ), Text(
          contentText2,
          style: AppFonts.body1.copyWith(fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ],
    );

    // set up the AlertDialog
    dynamic alert = Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                  confirmButton,
                ],
              )
            ],
          )
        : AlertDialog(
            title: title,
            content: content,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                  confirmButton,
                ],
              )
            ],
          );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static dynamic showAlertDialog(
    BuildContext context,
    String titleText,
    String contentText,
    String confirmText,
    String cancelText,
    Function() confirmFunction,
  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        cancelText,
        style: AppFonts.dialogColoredText
            .copyWith(color: Pallete.text, fontSize: 12),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget confirmButton = TextButton(
      child: Text(
        confirmText,
        style: AppFonts.dialogColoredText
            .copyWith(fontWeight: FontWeight.w600, color: Pallete.primaryColor),
      ),
      onPressed: confirmFunction,
    );

    // title
    Widget title = Center(
      child: Text(
        titleText,
        style: AppFonts.dialogColoredText.copyWith(
          fontWeight: FontWeight.w600,
          color: Pallete.primaryColor,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );

    // content
    Widget content = Text(
      contentText,
      style: AppFonts.body1.copyWith(fontSize: 13),
      textAlign: TextAlign.center,
    );

    // set up the AlertDialog
    dynamic alert = Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                  confirmButton,
                ],
              )
            ],
          )
        : AlertDialog(
            title: title,
            content: content,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                  confirmButton,
                ],
              )
            ],
          );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // static void showPay(context) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => const PayNotifier(),
  //   );
  // }

  static void showSnackBarMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
      elevation: 2,
      content: Text(message,
          style: const TextStyle(
              fontFamily: "AccordAlternate", color: Colors.white),
          textAlign: TextAlign.center),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black54,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static dynamic successDialog(BuildContext context, String titleText,
      String contentText, String closeText, Widget Icon, Function() confirmFunction,) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        closeText,
        style: AppFonts.dialogColoredText
            .copyWith(color: Pallete.black, fontSize: 12),
      ),
      onPressed: confirmFunction,
    );

    // title
    Widget title = Center(
      child: Column(
        children: [
          Icon,
          const SizedBox(
            height: 8,
          ),
          Text(
            titleText,
            style: AppFonts.coloredHeading.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    // content
    Widget content = Text(
      contentText,
      style: AppFonts.bodyText.copyWith(fontSize: 11, color: Pallete.text),
      textAlign: TextAlign.center,
    );

    // set up the AlertDialog
    dynamic alert = Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                ],
              )
            ],
          )
        : AlertDialog(
            title: title,
            content: content,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                ],
              )
            ],
          );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
 
  static dynamic ErrorDialog(BuildContext context, String titleText,
      String contentText, String cancelText, Widget Icon) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        cancelText,
        style: AppFonts.dialogColoredText
            .copyWith(color: Pallete.black, fontSize: 12),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );

    // title
    Widget title = Center(
      child: Column(
        children: [
          Icon,
          const SizedBox(
            height: 8,
          ),
          Text(
            titleText,
            style: AppFonts.coloredHeading.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    // content
    Widget content = Text(
      contentText,
      style: AppFonts.bodyText.copyWith(fontSize: 11, color: Pallete.text),
      textAlign: TextAlign.center,
    );

    // set up the AlertDialog
    dynamic alert = Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                ],
              )
            ],
          )
        : AlertDialog(
            title: title,
            content: content,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelButton,
                ],
              )
            ],
          );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  static dynamic PaymentSuccessDialog(BuildContext context, String titleText,
      String contentText,  Widget Icon) {
    // set up the buttons

    // title
    Widget title = Center(
      child: Column(
        children: [
          Icon,
          const SizedBox(
            height: 8,
          ),
          Text(
            titleText,
            style: AppFonts.coloredHeading.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    // content
    Widget content = Text(
      contentText,
      style: AppFonts.bodyText.copyWith(fontSize: 11, color: Pallete.text),
      textAlign: TextAlign.center,
    );

    // set up the AlertDialog
    dynamic alert = Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: content,
            actions: [
              
            ],
          )
        : AlertDialog(
            title: title,
            content: content,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
            actions: [
             
            ],
          );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // static dynamic showAlertDialog(
  //   BuildContext context,
  //   String titleText,
  //   String contentText,
  //   String confirmText,
  //   String cancelText,
  //   Function() confirmFunction,
  // ) {
  //   // set up the buttons
  //   Widget cancelButton = TextButton(
  //     child: Text(
  //       cancelText,
  //       style: AppFonts.dialogColoredText
  //           .copyWith(color: Pallete.kText, fontSize: 12),
  //     ),
  //     onPressed: () => Navigator.of(context).pop(),
  //   );

  //   Widget confirmButton = TextButton(
  //     child: Text(
  //       confirmText,
  //       style: AppFonts.dialogColoredText
  //           .copyWith(fontWeight: FontWeight.w600, color: Pallete.primaryColor),
  //     ),
  //     onPressed: confirmFunction,
  //   );

  //   // title
  //   Widget title = Center(
  //     child: Text(
  //       titleText,
  //       style: AppFonts.bodyThinColoured.copyWith(
  //         fontWeight: FontWeight.w600,
  //         fontSize: 17,
  //       ),
  //       textAlign: TextAlign.center,
  //     ),
  //   );

  //   // content
  //   Widget content = Text(
  //     contentText,
  //     style: AppFonts.bodyText.copyWith(fontSize: 13),
  //     textAlign: TextAlign.center,
  //   );

  //   // set up the AlertDialog
  //   dynamic alert = Platform.isIOS
  //       ? CupertinoAlertDialog(
  //           title: title,
  //           content: content,
  //           actions: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 cancelButton,
  //                 confirmButton,
  //               ],
  //             )
  //           ],
  //         )
  //       : AlertDialog(
  //           title: title,
  //           content: content,
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(14),
  //             ),
  //           ),
  //           backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
  //           actions: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 cancelButton,
  //                 confirmButton,
  //               ],
  //             )
  //           ],
  //         );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  static uuid() {
    var uuid = const Uuid();
    var v5 = uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com');
    return v5;
  }

  static dynamic showWarningDialog(
    BuildContext context,
    Widget icon,
    String contentText,
    String confirmText,
    String cancelText,
    Function() confirmFunction,
  ) {
    // set up the buttons
    Widget cancelButton = Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: OutlinedButton(
            child: Text(
              'Close',
              style:
                  AppFonts.bodyText.copyWith(color: Colors.white, fontSize: 14),
            ),
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(vertical: 16),
              primary: Colors.white,
              backgroundColor: Pallete.primaryColor,
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.of(context).pop()));

    Widget confirmButton = GestureDetector(
        onTap: confirmFunction,
        child: Text(
          confirmText,
          style: AppFonts.bodyText.copyWith(color: Colors.yellowAccent),
        ));

    // title

    // content
    Widget content = Text(
      contentText,
      style: AppFonts.bodyText.copyWith(fontSize: 12, color: Colors.black),
      textAlign: TextAlign.center,
    );

    // set up the AlertDialog
    dynamic alert = Platform.isIOS
        ? CupertinoAlertDialog(
            // content: content,
            actions: [
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  icon,
                  const SizedBox(
                    height: 24,
                  ),
                  content,
                  const SizedBox(
                    height: 24,
                  ),
                  cancelButton,
                  const SizedBox(
                    height: 8,
                  ),
                  confirmButton,
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            ],
          )
        : AlertDialog(
            //content: content,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
            actions: [
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  icon,
                  const SizedBox(
                    height: 24,
                  ),
                  content,
                  const SizedBox(
                    height: 24,
                  ),
                  cancelButton,
                  const SizedBox(
                    height: 8,
                  ),
                  confirmButton,
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            ],
          );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static bool checkValidEmail(value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static void showLoader(context) {
    showDialog(
      context: context,
      builder: (ctx) => const Loader(),
    );
  }


}
