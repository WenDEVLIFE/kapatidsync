import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscureText1 = true;
  bool obscureText2 = true;

  bool get isObscure1 => obscureText1;
  bool get isObscure2 => obscureText2;

  var role = ['Admin', 'Chruch Officer'];
  var selectedRole ='Admin';

  void toggleObscureText1() {
    obscureText1 = !obscureText1;
    notifyListeners();
  }

  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }


  void setRole(String? value) {
    selectedRole = value!;
    notifyListeners();
  }

  void clearData(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedRole = 'Admin';
  }

}