import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/Repositoryy/PasswordRepository.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:kapatidsync/src/widget/FlutterToastWidget.dart';

class ForgotPasswordViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();

  final PasswordRepository _passwordRepository = PasswordRepositoryImpl();

  void requestResetPassword(BuildContext context) async{
    bool result = await _passwordRepository.resetPassword(emailController.text);

    if(!result){
      // Show error message
      FlutterToastWidget().showMessage(ColorUtils.primaryColor, 'Error sending reset password email');
    } else {
      // Show success message
      FlutterToastWidget().showMessage(ColorUtils.primaryColor, 'Reset password email sent');
      Navigator.pop(context);
    }

  }


}