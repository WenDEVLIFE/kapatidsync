import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/ColorUtils.dart';

class AttendanceLogsUI extends StatelessWidget {
  const AttendanceLogsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: const Text('Attendance Logs', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),),
      ),
    );
  }
}