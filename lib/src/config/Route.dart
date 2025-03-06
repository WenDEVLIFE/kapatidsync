import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/ui/SplashUI.dart';

class RouteUtil {

  static const String splashScreen ='/splashScreen';

  Map <String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashUI(),
  };
}