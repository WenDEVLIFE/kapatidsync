import 'package:flutter/cupertino.dart';

import '../config/Route.dart';

class LoginViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  bool get isObscureText => obscureText;
  // Add your code here

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void LoginNow(BuildContext context){
    Navigator.pushNamed(context, RouteUtil.userPage);

  }

}