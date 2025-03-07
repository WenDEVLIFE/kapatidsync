import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/Route.dart';
import 'package:kapatidsync/src/ui/AttendanceLogsUI.dart';
import 'package:kapatidsync/src/ui/DashboardUI.dart';
import 'package:kapatidsync/src/ui/KidUI.dart';
import '../config/ColorUtils.dart';
import '../ui/MenuUI.dart';

class BottomNavigationWidget extends StatefulWidget {
  BottomNavigationWidget({super.key});

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const DashboardUI(),
    const KidUI(),
    const AttendanceLogsUI(),
    const MenuUI(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      // Handle logout action
      print('Logout');
      // You can add your logout logic here
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorUtils.primaryColor,
          title: const Text('Logout', style: TextStyle(
            color: ColorUtils.secondaryColor,
            fontSize: 20,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),),
          content: const Text('Are you sure you want to logout?',
            style: TextStyle(
              color: ColorUtils.secondaryColor,
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'
              , style: TextStyle(
                color: ColorUtils.secondaryColor,
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                  ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RouteUtil.loginScreen);
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: const Text('Yes' , style: TextStyle(
                color: ColorUtils.secondaryColor,
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),
              ),
            ),
          ],
        );
      }
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: ColorUtils.primaryColor,
        activeColor: ColorUtils.accentColor, // Set the active color
        inactiveColor: ColorUtils.secondaryColor, // Set the inactive color
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'Kids',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_plaintext),
            label: 'Attendance Logs',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Menu',
          ),
        ],
        onTap: _onItemTapped,
      ),
      tabBuilder: (BuildContext context, int index) {
        if (index == 3) {
          return const Center(
            child: Text('Logging out...'),
          );
        }
        return CupertinoTabView(
          builder: (BuildContext context) {
            return Center(
              child: _widgetOptions.elementAt(index),
            );
          },
        );
      },
    );
  }
}