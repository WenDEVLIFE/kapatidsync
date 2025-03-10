import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/Repositoryy/LoginRepository.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';

import '../config/Route.dart';

class LoginViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginRepository loginRepository = LoginRepositoryImpl();
  final SessionUtils sessionUtils = SessionUtils();

  bool obscureText = true;

  bool get isObscureText => obscureText;

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> LoginNow(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    // Simple check for empty credentials before attempting login
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorUtils.primaryColor,
            content: Text('Please enter both email and password',style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,

            ),)),
      );
      return;
    }

    try {
      Map<String, dynamic>? userData = await loginRepository.login(email, password);

      if (userData != null) {
        print(userData);
        // Save user info
        await sessionUtils.saveUserInfo(userData);

        // If login is successful, navigate based on user role
        Navigator.pushReplacementNamed(context, RouteUtil.userPage);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: ColorUtils.primaryColor,
              content: Text('Login successful!',style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,

              ),)),
        );
      } else {
        // Show error message if login failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: ColorUtils.accentColor,
              content: Text('Login Failed!',style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),)),
        );
      }
    } catch (e) {
      // Log the error
      print('Error: $e');
      // Handle any error that occurs during login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorUtils.accentColor,
            content: Text('An error occurred!',style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,

            ),)),
      );
    }
  }
}