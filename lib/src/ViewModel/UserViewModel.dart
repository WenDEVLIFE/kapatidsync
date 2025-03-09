import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText1 = true;
  bool obscureText2 = true;

  bool get isObscure1 => obscureText1;
  bool get isObscure2 => obscureText2;

  void toggleObscureText() {
    obscureText1 = !obscureText1;
    notifyListeners();
  }

}