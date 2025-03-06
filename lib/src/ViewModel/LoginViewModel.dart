import 'package:flutter/cupertino.dart';

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

}