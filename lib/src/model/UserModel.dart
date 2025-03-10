import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc){
    return UserModel(id: doc.id,
        name: doc['Name'],
        email: doc['Email'],
        role: doc['Role']);
  }
}