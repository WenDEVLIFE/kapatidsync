import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';

class MenuViewModel extends ChangeNotifier {

  SessionUtils sessionUtils = SessionUtils();

  String email = '';
  String name = '';

  MenuViewModel(){
    getUserInfo();
  }

  void getUserInfo() async {
   var userInfo = await sessionUtils.getUserInfo();
   email = userInfo?['email'];
   name = userInfo?['name'];

    notifyListeners();
  }

}