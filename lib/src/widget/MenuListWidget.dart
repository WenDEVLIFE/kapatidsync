import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';
import 'package:kapatidsync/src/widget/AlertDialogOptionWidget.dart';

import '../config/ColorUtils.dart';
import '../config/Route.dart';
import '../model/MenuItem.dart';

class MenuListWidget extends StatelessWidget {
  final String role;
  final Function(int) onItemSelected;
  late final List<MenuItem> menuItems;

  MenuListWidget({super.key, required this.onItemSelected, required this.role}) {
    menuItems = [
      MenuItem(icon: Icons.home, title: 'Dashboard',),
      MenuItem(icon: Icons.document_scanner, title: 'Kids'),
      if (role == 'Admin') MenuItem(icon: Icons.person, title: 'Users'),
      MenuItem(icon: CupertinoIcons.doc_plaintext, title: 'Attendance Logs'),
      MenuItem(icon: Icons.lock, title: 'Change Password'),
      MenuItem(icon: Icons.logout, title: 'Logout'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: ColorUtils.primaryColor, // Set the background color here
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(menuItems[index].icon, color: Colors.white, size: 22,),
                    title: Text(
                      menuItems[index].title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'SmoochSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      if (menuItems[index].title == 'Change Password') {
                        executePassword(context);
                      } else if (menuItems[index].title == 'Logout') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogOptionWidget(
                              title: 'Logout',
                              content: 'Are you sure you want to logout?',
                              onPressed: () {
                                SessionUtils sessionUtils = SessionUtils();
                                sessionUtils.clearUserInfo();
                                Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                                  RouteUtil.loginScreen,
                                      (Route<dynamic> route) => false,
                                );
                              },
                            ).build(context);
                          },
                        );
                      } else {
                        onItemSelected(index);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void executePassword(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(RouteUtil.changePassword);
  }
}