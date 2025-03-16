import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/Repositoryy/PasswordRepository.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final PasswordRepository _passwordRepository = PasswordRepositoryImpl();


  Future<void> changePassword(String newPassword) async {
    await _passwordRepository.changePassword(newPassword);
  }
}