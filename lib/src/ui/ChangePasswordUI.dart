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
      backgroundColor: ColorUtils.secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Enter the new password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.passwordController,
                style: const TextStyle(color: ColorUtils.primaryColor),
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(viewModel.isObscureText ? Icons.visibility_off : Icons.visibility),
                    color: ColorUtils.primaryColor,
                    onPressed: () {
                      viewModel.toggleObscureText();
                    },
                  ),
                  hintText: 'New Password',
                  hintStyle: const TextStyle(color: ColorUtils.primaryColor,
                      fontFamily: 'Lato',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorUtils.primaryColor),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorUtils.primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.7,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  viewModel.changePassword();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Change Password',
                  style: TextStyle(
                    color: Colors.white, // Ensure the text color is white
                    fontSize:14,
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