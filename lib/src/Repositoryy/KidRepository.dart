import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/widget/FlutterToastWidget.dart';

import '../model/KidModel.dart';

abstract class KidRepository {
  Future<void> insertKid(Map<String, dynamic> kidData);
  Stream<List<KidModel>> getKids();
  Future<void> recordAttendance(List<KidModel> selectedKids);
  Future<void> deleteKid(String kidId);
}

class KidRepositoryImpl implements KidRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> insertKid(Map<String, dynamic> kidData) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore.collection('kids').where('Name', isEqualTo: kidData['name']).get();
      if (querySnapshot.docs.isEmpty) {
        await firebaseFirestore.collection('kids').add({
          'Name': kidData['name'],
          'Age': kidData['age'],
          'Gender': kidData['gender'],
          'Purok': kidData['purok'],
          'PhoneNumber': kidData['contact'],
          'Birthdate': kidData['birthdate'],
          'Address': kidData['address'],
          'ParentName': kidData['parentName'],
          'registeredAt': Timestamp.now(),
        });
        FlutterToastWidget().showMessage(Colors.green, "Kid added successfully");
      } else {
        print('Name already exists');
        FlutterToastWidget().showMessage(Colors.red, "Name already exists");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<List<KidModel>> getKids() {
    return firebaseFirestore.collection('kids').snapshots().map((snapshot) => snapshot.docs.map((doc) => KidModel.fromDocumentSnapShot(doc)).toList());
  }

  @override
  Future<void> recordAttendance(List<KidModel> selectedKids) async {
    QuerySnapshot attendanceSnapshot = await firebaseFirestore.collection('attendancecollection').get();
    int attendanceCount = attendanceSnapshot.size;

    try {
      DocumentReference attendanceDocRef = await firebaseFirestore.collection('attendancecollection').add({
        'Date': Timestamp.now(),
        'Category': 'Attendance ${attendanceCount == 0 ? 1 : attendanceCount + 1}',
      });

      for (KidModel kid in selectedKids) {

        DateTime now = DateTime.now();
        String formattedDate = "${now.year}-${now.month}-${now.day}";
        String formattedTime = "${now.hour}:${now.minute}";
        await attendanceDocRef.collection('KidCollection').add({
          'KidID': kid.id,
          'Name': kid.fullname,
          'Age': kid.age,
          'Gender': kid.gender,
          'Purok': kid.purok,
          'DateIn':formattedDate,
          'TimeIn': formattedTime,
          'isAttended': kid.isSelected,
          'registeredAt': Timestamp.now(),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteKid(String kidId) {
    return firebaseFirestore.collection('kids').doc(kidId).delete();
  }
}