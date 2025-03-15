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
  Future<void> addKidToAttendance(String attendanceId, KidModel kid, TimeOfDay time, bool isAttended);
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
        String formattedTime = kid.isSelected ? "${now.hour}:${now.minute}" : "No Time In";
        await attendanceDocRef.collection('KidCollection').add({
          'KidID': kid.id,
          'Name': kid.fullname,
          'Age': kid.age,
          'Gender': kid.gender,
          'Purok': kid.purok,
          'DateIn': formattedDate,
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

  @override
  Future<void> addKidToAttendance(String attendanceId, KidModel kid, TimeOfDay time, bool isAttended) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = "${now.year}-${now.month}-${now.day}";
      String? formattedTime = isAttended ? "${time.hour}:${time.minute}" : "No Time In";

      // Check if the kid already exists in the KidCollection
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('attendancecollection')
          .doc(attendanceId)
          .collection('KidCollection')
          .where('KidID', isEqualTo: kid.id)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Kid does not exist, add to KidCollection
        await firebaseFirestore
            .collection('attendancecollection')
            .doc(attendanceId)
            .collection('KidCollection')
            .add({
          'KidID': kid.id,
          'Name': kid.fullname,
          'Age': kid.age,
          'Gender': kid.gender,
          'Purok': kid.purok,
          'DateIn': formattedDate,
          'TimeIn': formattedTime,
          'isAttended': isAttended,
          'registeredAt': Timestamp.now(),
        });
        FlutterToastWidget().showMessage(Colors.green, "Kid added to attendance successfully");
      } else {
        // Kid already exists
        FlutterToastWidget().showMessage(Colors.red, "Kid already exists in attendance");
      }
    } catch (e) {
      print(e);
      FlutterToastWidget().showMessage(Colors.red, "Failed to add kid to attendance");
    }
  }
}