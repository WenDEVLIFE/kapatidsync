import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/ColorUtils.dart';

class UserUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: const Text('List of Users', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        )),
      ),
      body: Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.accentColor,
          onPressed : (){

          },
          child: const Icon(Icons.person_add, color: ColorUtils.secondaryColor,),
      ),

    );
  }


}