
import 'package:abjatenant/views/auth/welcome/confirm.dart';
import 'package:abjatenant/views/auth/welcome/get_code.dart';
import 'package:abjatenant/views/auth/welcome/get_code_res.dart';
import 'package:abjatenant/views/auth/welcome/welcome.dart';
import 'package:abjatenant/views/emergency/emergency_contact.dart';
import 'package:abjatenant/views/notification/notification.dart';
import 'package:abjatenant/views/profile/edit_profile.dart';
import 'package:abjatenant/views/profile/profile.dart';
import 'package:abjatenant/views/task/success.dart';
import 'package:abjatenant/views/task/task.dart';
import 'package:flutter/widgets.dart';

import '../views/auth/forgotPassword/change_password.dart';
import '../views/auth/forgotPassword/forgotPassword.dart';
import '../views/auth/forgotPassword/otp.dart';
import '../views/auth/loading.dart';
import '../views/auth/login/login.dart';
import '../views/auth/TC.dart';
import '../views/auth/register/register.dart';
import '../views/auth/register/register_otp.dart';
import '../views/dashboard/dashboard.dart';
import '../views/navbar/nav.dart';
import '../views/property/details/property-details.dart';

class AppRoutes {
  static const dashboardScreen = '/dashboardScreen';
  static const propDetails = '/propDetails';
  static const welcomeScreen = '/welcomeScreen';
    static const getCodeScreen = '/getCodeScreen';
        static const getCodeResScreen = '/getCodeResScreen';
  static const chat = '/chatScreen';
  static const speakWithDoc = './speakWithDoc';
  static const profile = '/profile';
  static const editProfile = '/editProfile';
  static const about = './history';
  static const bookATest = './bookATest';
  static const randomSearch = '/randomSearchScreen';
  static const testScreen = '/testScreen';
  static const viewAllCart = '/viewAllCart';
  static const drugItemScreen = '/drugItem';
  static const webviewScreen = '/webview';
  static const checkOut = '/checkOut';
  static const seeAllCart = '/seeAllCart';
  static const refer = '/refer';
  static const loginScreen = '/loginScreen';
  static const forgotPassword = '/forgotPassword';
  static const selectTest = '/selectTest';
  static const ordersScreen = '/ordersScreen';
  static const drugOrdersScreen = '/drugOrdersScreen';
  static const diag = '/diag';
  static const package = '/package';
  static const navbar = '/navbar';
  static const loadHome = '/loadHome';
  static const privacy = '/privacy';
  static const terms = '/terms';
    static const taskScreen = '/taskScreen';
     static const success = '/success';
   static const notification = '/notification';
   static const emergencyContact = '/emergencyContact';
  static const registerOTPScreen = '/registerOTPScreen';
  static const changePassword = '/changePassword';
  static const registerScreen = '/registerScreen';
  static const resetOTPScreen = '/resetOTPScreen';
   static const confirmLandlordScreen = '/confirmLandlordScreen';
  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      AppRoutes.forgotPassword: ((context) => PasswordResetScreen()),
            AppRoutes.profile: ((context) => Profile()),
                AppRoutes.editProfile: ((context) => EditProfile()),
                  AppRoutes.taskScreen: ((context) => Task()),
                AppRoutes.profile: ((context) => Profile()),
                  AppRoutes.emergencyContact: ((context) => EmergencyContact()),
                   AppRoutes.success: ((context) => Success()),
          AppRoutes.getCodeScreen: ((context) => const GetCode()),
           AppRoutes.welcomeScreen: ((context) => const Welcome()),
          AppRoutes.getCodeResScreen: ((context) => const GetCodeResponse()),
      AppRoutes.changePassword: (context) => NewPasswordScreen(),
       AppRoutes.notification: (context) => NotificationScreen(),
      AppRoutes.registerOTPScreen: (context) => RegisterOTPScreen(),
      AppRoutes.resetOTPScreen: (context) => ResetOTPScreen(),
      AppRoutes.loginScreen: (context) => LoginScreen(),
      AppRoutes.registerScreen: (context) => SignUp(),
        AppRoutes.loadHome: (context) => LoadingHomeScreen(),
        AppRoutes.package: (context) =>TermsAndConditions(),
         AppRoutes.dashboardScreen: (context) =>Dashboard(),
          AppRoutes.confirmLandlordScreen: (context) =>ConfirmLandlord(),
              AppRoutes.navbar: (context) =>NavBar(),
                   AppRoutes.propDetails: (context) =>PropertyDetails(),
    };
  }
}
