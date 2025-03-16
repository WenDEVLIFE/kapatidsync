import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/Route.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';
import 'package:kapatidsync/src/ui/AttendanceLogsUI.dart';
import 'package:kapatidsync/src/ui/DashboardUI.dart';
import 'package:kapatidsync/src/ui/KidUI.dart';
import 'package:kapatidsync/src/widget/AlertDialogOptionWidget.dart';
import 'package:kapatidsync/src/widget/DrawerWidget.dart';
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
  SessionUtils sessionUtils = SessionUtils();
  late Future<String> roleFuture;

  @override
  void initState() {
    super.initState();
    roleFuture = init();
  }

  Future<String> init() async {
    var userdata = await sessionUtils.getUserInfo();
    return userdata!['role'];
  }

  final List<Widget> _widgetOptions = <Widget>[
    const DashboardUI(),
    const KidUI(),
    UserUI(),
    const AttendanceLogsUI(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: roleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var role = snapshot.data!;
          return CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              backgroundColor: ColorUtils.primaryColor,
              activeColor: ColorUtils.accentColor,
              inactiveColor: ColorUtils.secondaryColor,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner),
                  label: 'Kids',
                ),
                if (role == 'Admin')
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: 'Users',
                  ),
                const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.doc_plaintext),
                  label: 'Attendance Logs',
                ),
              ],
              onTap: _onItemTapped,
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoPageScaffold(
                child: Scaffold(
                  drawer: const DrawerWidget(),
                  body: Center(
                    child: _widgetOptions.elementAt(index),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}