import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';

class AlertDialogOptionWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  AlertDialogOptionWidget({required this.title, required this.content, required this.onPressed});

  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorUtils.primaryColor,
      title: Text(title, style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      )),
      content: Text(content, style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
      )),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: const Text('Yes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}