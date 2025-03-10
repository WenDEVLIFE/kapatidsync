import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/widget/AddUserDialog.dart';

import '../config/ColorUtils.dart';

class UserUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
          SizedBox(height: screenHeight * 0.005),
          Container(
            width: screenWidth * 0.99,
            height: screenHeight * 0.08,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent, width: 7),
            ),
            child: TextField(
             // controller: _subscriptionViewModel.searchController,
              onChanged: (query) {
             //   _subscriptionViewModel.filterSubscriptions(query);
              },
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent, width: 2),
                ),
                hintText: 'Search a user....',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              ),
              style: const TextStyle(
                fontFamily: 'LeagueSpartan',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.accentColor,
          onPressed : (){
          showDialog(context: context, builder: (BuildContext context){
            return AddUserDialog();
          });

          },
          child: const Icon(Icons.person_add, color: ColorUtils.secondaryColor,),
      ),

    );
  }


}