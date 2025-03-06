import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/ui/LoginUI.dart';
import 'package:kapatidsync/src/ui/SplashUI.dart';

class RouteUtil {

  static const String splashScreen ='/splashScreen';
  static const String loginScreen ='/loginScreen';

  static Map <String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashUI(),
    loginScreen: (context) => const LoginUi(),
  };
}