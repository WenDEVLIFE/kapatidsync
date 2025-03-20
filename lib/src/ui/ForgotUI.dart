import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/ForgotPasswordViewModel.dart';
import 'package:kapatidsync/src/ViewModel/LoginViewModel.dart';
import 'package:kapatidsync/src/widget/CustomPasswordTextField.dart';
import 'package:kapatidsync/src/widget/CustomText.dart';
import 'package:provider/provider.dart';

import '../config/ColorUtils.dart';
import '../widget/CustomElevatedButton.dart';
import '../widget/CustomTextField.dart';

class ForgotUi extends StatelessWidget {
  const ForgotUi({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordViewModel viewModel = Provider.of<ForgotPasswordViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CustomText(fontSize: 30,
                    text: 'Forgot Password',
                    color: ColorUtils.secondaryColor
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                    controller: viewModel.emailController,
                    screenHeight: screenHeight,
                    hintText: 'Email',
                    fontSize: 20,
                    keyboardType: TextInputType.text
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(height: screenHeight * 0.02),
                CustomElevatedButton(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  onPressed: () {
                    viewModel.requestResetPassword(context);
                  },
                  text: 'Login',
                ),
              ],
            ),

          )
      ),
    );
  }
}