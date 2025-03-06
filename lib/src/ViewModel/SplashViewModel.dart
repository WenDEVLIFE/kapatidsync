import 'package:flutter/cupertino.dart';

import '../config/Route.dart';

class SplashViewModel extends ChangeNotifier {

   bool loading = false;

  bool get isLoading => loading;

  Future<void> setLoading(BuildContext context) async {
    loading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushNamed(context, RouteUtil.loginScreen);
  }
}