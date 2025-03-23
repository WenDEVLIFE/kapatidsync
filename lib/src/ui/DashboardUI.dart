import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapatidsync/src/widget/CustomText.dart';
import 'package:kapatidsync/src/widget/DashboardCard.dart';

class DashboardUI extends StatelessWidget {
  const DashboardUI({super.key});

  Stream<int> _getCount(String collection) {
    return FirebaseFirestore.instance.collection(collection).snapshots().map((snapshot) => snapshot.docs.length);
  }

  Stream<int> _getOfficerCount() {
    return FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'Church Officer').snapshots().map((snapshot) => snapshot.docs.length);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title:  const CustomText(
          text: 'Dashboard',
          fontSize: 20,
          color: ColorUtils.secondaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            const Padding(
              padding: EdgeInsets.all(20),
              child:
                  CustomText(
                      text: 'Welcome to KapatidSync',
                    fontSize: 20,
                    color: ColorUtils.primaryColor,
                  ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: DashboardCard(
                    icon: Icons.person,
                    label: 'USER',
                    stream: _getCount('users'),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: DashboardCard(
                    icon: Icons.group,
                    label: 'KIDS',
                    stream: _getCount('kids'),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: DashboardCard(
                    icon: Icons.file_copy,
                    label: 'ATTENDANCE LOGS',
                    stream: _getCount('attendancecollection'),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: DashboardCard(
                    icon: Icons.group,
                    label: 'OFFICERS',
                    stream: _getOfficerCount(),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
              ],
            ),
          ],
        ),
      ),
    );
  }
}