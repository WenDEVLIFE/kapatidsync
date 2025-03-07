import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/ColorUtils.dart';

class KidUI extends StatelessWidget {
  const KidUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: const Text('List of Kids', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),),
      ),
    );
  }
}