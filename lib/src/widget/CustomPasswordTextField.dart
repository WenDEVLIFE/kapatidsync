import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  final double screenHeight;
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;

  const CustomPasswordTextField({
    required this.screenHeight,
    required this.hintText,
    required this.controller,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
     child: TextField(
       controller:controller,
       style: const TextStyle(color: Colors.white),
       obscureText:isPasswordVisible,
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
           icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
           color: Colors.white,
           onPressed:(){
             togglePasswordVisibility();
           }
         ),
       ),
     ),
    );
  }
}