import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/ChangePasswordViewModel.dart';
import 'package:provider/provider.dart';

import '../config/ColorUtils.dart';

class ChangePasswordUI extends StatelessWidget {
  const ChangePasswordUI({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordViewModel viewModel = Provider.of<ChangePasswordViewModel>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: const Text('Change Password', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        )),
      ),
      backgroundColor: ColorUtils.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Enter the new password',
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
                controller: passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'New Password',
                  hintStyle: TextStyle(color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 20,
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
              height: screenHeight * 0.08,
              child: ElevatedButton(
                onPressed: () {
                  viewModel.changePassword(passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.01),
                ),
                child: const Text('Change Password',
                  style: TextStyle(
                    color: ColorUtils.secondaryColor,
                    fontSize: 20,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}