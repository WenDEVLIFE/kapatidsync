import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';

import '../config/Route.dart';

class SplashViewModel extends ChangeNotifier {

   bool loading = false;

  bool get isLoading => loading;

  final SessionUtils sessionUtils = SessionUtils();

  Future<void> setLoading(BuildContext context) async {
    loading = true;
    notifyListeners();

    var userdata = sessionUtils.getUserInfo();

    await Future.delayed(const Duration(seconds: 5));

    // Check if the context is mounted
    if (context.mounted) {
      if (userdata != null) {
        Navigator.pushReplacementNamed(context, RouteUtil.userPage);
      } else {
        Navigator.pushReplacementNamed(context, RouteUtil.loginScreen);
      }
       }
  }
}