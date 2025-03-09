import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/FirebaseService.dart';

class CheckDataUtils {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future <bool> checkIfUserExist(String email) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: FirebaseServices.adminEmail,
      password: FirebaseServices.adminPassword,
    );

    User? user = userCredential.user;
    if (user != null) {
      final QuerySnapshot emailResult = await firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      return emailResult.docs.isEmpty;
    } else {
      return false;
    }
  }

  Future <bool> checkIfNameExist(String name) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: FirebaseServices.adminEmail,
      password: FirebaseServices.adminPassword,
    );

    User? user = userCredential.user;
    if (user != null) {
      final QuerySnapshot nameResult = await firestore
          .collection('Users')
          .where('name', isEqualTo: name)
          .get();
      return nameResult.docs.isEmpty;
    } else {
      return false;
    }
  }


  Future <bool> validateEmail(String email) async {
    String emailpattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(emailpattern).hasMatch(email);
  }

  Future checkPassword(String password, String confirmpassword) async {
    return password == confirmpassword;
  }

  Future <bool> checkPasswordComplexity(String password) async {
    String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    return RegExp(passwordPattern).hasMatch(password);
  }
}