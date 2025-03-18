import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';

class CustomElevatedButton extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtils.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.01),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: ColorUtils.secondaryColor,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}