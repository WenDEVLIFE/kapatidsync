import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/ui/ChangePasswordUI.dart';
import 'package:kapatidsync/src/ui/LoginUI.dart';
import 'package:kapatidsync/src/ui/SplashUI.dart';
import 'package:kapatidsync/src/widget/BottomNavigationWidget.dart';

import '../ui/ForgotUI.dart';
import '../ui/KidAttendanceUI.dart';

class RouteUtil {

  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String userPage = '/userPage';
  static const String changePassword = '/changePassword';
  static const String forgotPassword = '/forgotPassword';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashUI(),
    loginScreen: (context) => const LoginUi(),
    userPage: (context) => BottomNavigationWidget(),
    changePassword: (context) => const ChangePasswordUI(),
    forgotPassword: (context) => const ForgotUi(),
  };
}