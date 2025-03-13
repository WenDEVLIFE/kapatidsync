import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/widget/FlutterToastWidget.dart';

import '../model/KidModel.dart';

abstract class KidRepository {
  Future<void> insertKid(Map<String, dynamic> kidData);

  Stream<List<KidModel>> getKids();
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
          'Contact': kidData['contact'],
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
}