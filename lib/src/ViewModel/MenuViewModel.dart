import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/config/ImageUtils.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';

class MenuViewModel extends ChangeNotifier {

  SessionUtils sessionUtils = SessionUtils();

  String email = '';
  String name = '';
  String role = '';
  String profilepath = '';

  MenuViewModel() {
    getUserInfo();
  }

  void getUserInfo() async {
    var userInfo = await sessionUtils.getUserInfo();
    email = userInfo?['email'] ?? '';
    name = userInfo?['name'] ?? '';
    role = userInfo?['role'] ?? '';

    if (role == 'Admin') {
      profilepath = ImageUtils.adminPath;
    } else {
      profilepath = ImageUtils.officerPath;
    }

    notifyListeners();
  }
}