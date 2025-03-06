import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/LoginViewModel.dart';
import 'package:provider/provider.dart';

import '../config/ColorUtils.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: viewModel.emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white ,
                        fontFamily: 'Lato' ,
                        fontSize: 20 ,
                        fontWeight: FontWeight.w400),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: viewModel.passwordController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: viewModel.isObscureText,
                  decoration: InputDecoration(
                    hintText: 'Password' ,
                    hintStyle: const TextStyle(color: Colors.white ,
                        fontFamily: 'Lato' ,
                        fontSize: 20 ,
                        fontWeight: FontWeight.w400),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(viewModel.isObscureText ? Icons.visibility : Icons.visibility_off),
                      color: Colors.white,
                      onPressed: () {
                        viewModel.toggleObscureText();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  // Add your code here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.01),
                ),
                child: const Text('Login',
                  style: TextStyle(
                    color: ColorUtils.secondaryColor,
                    fontSize: 20,
                    fontFamily: 'BigShouldersInline',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

            ],
          ),

        )
      ),
    );
  }
}