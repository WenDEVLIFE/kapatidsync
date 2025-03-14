import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: const Text('Dashboard', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Welcome to KapatidSync', style: TextStyle(
                color: ColorUtils.primaryColor,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              )),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        color: ColorUtils.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person, color: Colors.white, size: 50),
                            SizedBox(height: screenHeight * 0.01),
                            const Text('USER', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            )),
                            SizedBox(height: screenHeight * 0.01),
                            StreamBuilder<int>(
                              stream: _getCount('users'),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text('${snapshot.data}', style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                } else {
                                  return const Text('0', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        color: ColorUtils.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.group, color: Colors.white, size: 50),
                            SizedBox(height: screenHeight * 0.01),
                            const Text('KIDS', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            )),
                            SizedBox(height: screenHeight * 0.01),
                            StreamBuilder<int>(
                              stream: _getCount('kids'),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text('${snapshot.data}', style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                } else {
                                  return const Text('0', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        color: ColorUtils.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.file_copy, color: Colors.white, size: 50),
                            SizedBox(height: screenHeight * 0.01),
                            const Text('ATTENDANCE LOGS', style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            )),
                            SizedBox(height: screenHeight * 0.01),
                            StreamBuilder<int>(
                              stream: _getCount('attendancecollection'),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text('${snapshot.data}', style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                } else {
                                  return const Text('0', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        color: ColorUtils.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.group, color: Colors.white, size: 50),
                            SizedBox(height: screenHeight * 0.01),
                            const Text('OFFICERS', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            )),
                            SizedBox(height: screenHeight * 0.01),
                            StreamBuilder<int>(
                              stream: _getOfficerCount(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text('${snapshot.data}', style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                } else {
                                  return const Text('0', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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