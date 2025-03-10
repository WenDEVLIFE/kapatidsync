
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/widget/AlertDialogOptionWidget.dart';

import '../config/Route.dart';
import '../model/MenuItem.dart';

class MenuListWidget extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(icon: Icons.password, title: 'Change Password'),
    MenuItem(icon: Icons.check, title: 'Terms and Conditions'),
    MenuItem(icon: Icons.info_outline, title: 'About Us'),
    MenuItem(icon: Icons.logout, title: 'Logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(menuItems[index].icon, color: Colors.black, size: 22,),
                title: Text(menuItems[index].title,
                  style: const TextStyle(fontSize: 18,
                    fontFamily: 'SmoochSans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  // Handle menu item tap
               if (index == 0) {
                    // Privacy Policy

                  } else if (index == 1) {
                    // About Us

                  }
               else if (index == 2) {
                 // About Us

               }
               else if (index == 3) {
                    // Logout
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialogOptionWidget(
                        title: 'Logout',
                        content: 'Are you sure you want to logout?',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RouteUtil.loginScreen);
                        },
                      ).build(context);
                    }
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}