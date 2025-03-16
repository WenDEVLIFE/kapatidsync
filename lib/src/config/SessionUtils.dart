// TODO : Added session functions
import 'package:shared_preferences/shared_preferences.dart';

class SessionUtils {
  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userInfo['email']);
    prefs.setString('role', userInfo['role']);
    prefs.setString('name', userInfo['name']);
    prefs.setString('uid', userInfo['uid']);
    prefs.setString('password', userInfo['password']);
    print('User Info Saved');
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('email')) {
      return {
        'email': prefs.getString('email'),
        'role': prefs.getString('role'),
        'name': prefs.getString('name'),
        'uid': prefs.getString('uid'),
        'password': prefs.getString('password')
      };
    }
    return null;
  }

  Future<void> updateEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  Future<void> updatePassword(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }

  Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('role');
    prefs.remove('name');
    prefs.remove('uid');
    prefs.remove('password');
  }
}