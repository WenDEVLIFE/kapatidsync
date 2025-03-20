import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/LoginViewModel.dart';
import 'package:kapatidsync/src/widget/CustomPasswordTextField.dart';
import 'package:kapatidsync/src/widget/CustomText.dart';
import 'package:provider/provider.dart';

import '../config/ColorUtils.dart';
import '../config/Route.dart';
import '../widget/CustomElevatedButton.dart';
import '../widget/CustomTextField.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                    fontSize: 30,
                    text: 'Login',
                    color: ColorUtils.secondaryColor,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    controller: viewModel.emailController,
                    screenHeight: screenHeight,
                    hintText: 'Email',
                    fontSize: 20,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomPasswordTextField(
                    screenHeight: screenHeight,
                    hintText: 'Password',
                    controller: viewModel.passwordController,
                    isPasswordVisible: viewModel.isObscureText,
                    togglePasswordVisibility: viewModel.toggleObscureText,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomElevatedButton(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onPressed: () {
                      viewModel.LoginNow(context);
                    },
                    text: 'Login',
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteUtil.forgotPassword);
              },
              child: const CustomText(
                text: 'Forgot Password',
                fontSize: 20,
                color: ColorUtils.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}