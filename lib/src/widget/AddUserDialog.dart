import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/UserViewModel.dart';
import 'package:provider/provider.dart';

class AddUserDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel viewModel = Provider.of<UserViewModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return AlertDialog(
      title: const Text("Add User"
      ,style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      )
    ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
               // controller: viewModel.emailController,
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
                obscureText: viewModel.isObscure1,
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
                    icon: Icon(viewModel.isObscure1 ? Icons.visibility : Icons.visibility_off),
                    color: Colors.white,
                    onPressed: () {
                      viewModel.toggleObscureText();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),


    );
  }
  
  
}