import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final double fontSize;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.fontSize,
    required this.text,
    required this.color,
    required this.onPressed,
  });


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
        style: TextStyle(color: color,
            fontFamily: 'Lato' ,
            fontSize: fontSize ,
            fontWeight: FontWeight.w400
        ),
      ),
    );
  }

}