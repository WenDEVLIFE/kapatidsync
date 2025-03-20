import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';

abstract class PasswordRepository {
  Future<void> changePassword(String newPassword);
  Future<bool> resetPassword(String email);
}

class PasswordRepositoryImpl implements PasswordRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Change password
  @override
  Future<void> changePassword(String newPassword) async {
    try {
      SessionUtils sessionUtils = SessionUtils();
      var user = _firebaseAuth.currentUser;

      if (user != null) {
        // Re-authenticate the user
        var userInfo = await sessionUtils.getUserInfo();
        String email = userInfo?['email'];
        String password = userInfo?['password'];
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        await sessionUtils.updatePassword(newPassword);
        Fluttertoast.showToast(msg: "Password changed successfully", backgroundColor: Colors.green);
      } else {
        Fluttertoast.showToast(msg: "No user is signed in", backgroundColor: Colors.red);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
  }

  // Reset password
  @override
  Future<bool>  resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }
}