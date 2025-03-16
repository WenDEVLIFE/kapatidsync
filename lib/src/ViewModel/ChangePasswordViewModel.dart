import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/Repositoryy/PasswordRepository.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final PasswordRepository _passwordRepository = PasswordRepositoryImpl();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  bool get isObscureText => obscureText;


  Future<void> changePassword() async {
    await _passwordRepository.changePassword(passwordController.text);
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }
}