import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/ui/LoginUI.dart';
import 'package:kapatidsync/src/ui/SplashUI.dart';
import 'package:kapatidsync/src/widget/BottomNavigationWidget.dart';

import '../ui/KidAttendanceUI.dart';

class RouteUtil {

  static const String splashScreen ='/splashScreen';
  static const String loginScreen ='/loginScreen';
  static const String userPage ='/userPage';
  static const String kidAttendance ='/kidAttendance';

  static Map <String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashUI(),
    loginScreen: (context) => const LoginUi(),
    userPage: (context) => BottomNavigationWidget(),
    kidAttendance: (context) => KidAttendanceUI(),
  };
}