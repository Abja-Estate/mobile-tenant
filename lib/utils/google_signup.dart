// // function to implement the google signin

// // creating firebase instance
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:pharmplug/utils/cache.dart';
// import 'package:pharmplug/views/dashboard/dashboard.dart';

// Future googleSignUp(BuildContext context) async {
//   try {
//     //initialize GoogleSignIn
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
//     //get authentication details from request
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//     //create a new user from their credentials
//     final credentials = GoogleAuthProvider.credential(
//         accessToken: gAuth.accessToken, idToken: gAuth.idToken);

//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credentials);

//     print(userCredential.user!.photoURL);
//     await CacheUtil.saveEmail(userCredential.user!.email.toString());
//     await CacheUtil.saveName(userCredential.user!.displayName.toString());
//     await CacheUtil.savePhone(userCredential.user!.phoneNumber.toString());
//     await CacheUtil.savePhoto(userCredential.user!.photoURL.toString());
        
//   } catch (error) {

//     print(error);
//   }
// }
