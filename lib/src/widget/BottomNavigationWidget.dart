import 'package:flutter/cupertino.dart';
import '../config/ColorUtils.dart';

class BottomNavigationWidget extends StatelessWidget {
  BottomNavigationWidget({super.key});

  final List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Person'),
    Text('Settings'),
  ];

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
            icon: Icon(CupertinoIcons.search),
            label: 'Person',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
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