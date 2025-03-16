import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ui/MenuUI.dart';

class DrawerWidget extends StatelessWidget {
  final Function(int) onItemSelected;

  const DrawerWidget({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MenuUI(onItemSelected: onItemSelected),
    );
  }
}