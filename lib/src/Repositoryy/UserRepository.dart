import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:kapatidsync/src/model/UserModel.dart';
import 'package:kapatidsync/src/widget/FlutterToastWidget.dart';

abstract class UserRepository {
 Future<void> addUser(Map<String, dynamic> userdata);
 Future<void> deleteUser(String uid);
 Stream<List<UserModel>> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> addUser(Map<String, dynamic> userdata) async {

    String email = userdata['email'];
    String password = userdata['password'];
    String name = userdata['name'];
    String role = userdata['role'];

    // Register user in Firebase Authentication
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Add user data to Firestore
    await firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
      'Email': email,
      'Name': name,
      'Role': role,
    });

    FlutterToastWidget().showMessage(ColorUtils.primaryColor, 'User added successfully');

  }

  // Load the user from the firebase
  @override
  Stream<List<UserModel>> getUsers() {
   return firebaseFirestore.collection('users').snapshots().map((snapshot) => snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList());
  }

  // Delete the user from the database
  @override
  Future<void> deleteUser(String uid) {
    return firebaseFirestore.collection('users').doc(uid).delete();
  }

}