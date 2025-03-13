import 'package:cloud_firestore/cloud_firestore.dart';

class KidModel {
  final String id;
  final String fullname;
  final String age;
  final String gender;
  final String address;
  final String phoneNumber;
  final String parentName;

  KidModel({
    required this.id,
    required this.fullname,
    required this.age,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.parentName,
  });

  factory KidModel.fromDocumentSnapShot(DocumentSnapshot doc) {
    return KidModel(
      id: doc.id,
      fullname: doc['Name'],
      age: doc['Age'],
      gender: doc['Gender'],
      address: doc['Address'],
      phoneNumber: doc['Contact'],
      parentName: doc['ParentName'],
    );
  }
}