import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/Route.dart';
import 'package:kapatidsync/src/ui/AttendanceLogsUI.dart';
import 'package:kapatidsync/src/ui/DashboardUI.dart';
import 'package:kapatidsync/src/ui/KidUI.dart';
import 'package:kapatidsync/src/widget/AlertDialogOptionWidget.dart';
import '../config/ColorUtils.dart';
import '../ui/MenuUI.dart';
import '../ui/UserUI.dart';

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
    UserUI(),
    const AttendanceLogsUI(),
    const MenuUI(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      // Handle logout action
      print('Logout');

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
            icon: Icon(CupertinoIcons.person_2_fill),
            label: 'Users',
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