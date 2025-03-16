import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/Repositoryy/UserRepository.dart';
import 'package:kapatidsync/src/config/CheckDataUtils.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:kapatidsync/src/config/SessionUtils.dart';
import 'package:kapatidsync/src/widget/FlutterToastWidget.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../model/UserModel.dart';

class UserViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final CheckDataUtils checkDataUtils = CheckDataUtils();
  final UserRepository userRepository = UserRepositoryImpl();

  bool obscureText1 = true;
  bool obscureText2 = true;

  bool get isObscure1 => obscureText1;
  bool get isObscure2 => obscureText2;

  List<UserModel> users = [];
  List<UserModel> filterUsers = [];

  // Get users
  List<UserModel> get getUser => filterUsers;

  Stream<List<UserModel>> get userStream => userRepository.getUsers();

  var role = ['Admin', 'Church Officer'];
  var selectedRole = 'Admin';

  // initialize
  UserViewModel() {
    _listenToUserStream();
  }

  // view password & hide password
  void toggleObscureText1() {
    obscureText1 = !obscureText1;
    notifyListeners();
  }

  // view password & hide password
  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }

  // Set users
  void setUsers(List<UserModel> userList) {
    users = userList;
    filterUsers = userList;
    notifyListeners();
  }

  // Set role
  void setRole(String? value) {
    selectedRole = value!;
    notifyListeners();
  }

  // clear data
  void clearData() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedRole = 'Admin';
  }

  // Add user listener
  Future<void> addUser() async {
    bool checkEmail = await checkDataUtils.validateEmail(emailController.text);
    bool checkPassword = await checkDataUtils.checkPassword(passwordController.text, confirmPasswordController.text);
    bool checkPasswordComplexity = await checkDataUtils.checkPasswordComplexity(passwordController.text);
    bool checkIfUserExist = await checkDataUtils.checkIfUserExist(emailController.text);
    bool checkIfNameExist = await checkDataUtils.checkIfNameExist(nameController.text);

    if (emailController.text.isEmpty) {
      print('Email is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Email is empty');
      return;
    }

    if (passwordController.text.isEmpty) {
      print('Password is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Password is empty');
      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      print('Confirm Password is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Confirm Password is empty');
      return;
    }

    if (nameController.text.isEmpty) {
      print('Name is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Name is empty');
      return;
    }

    if (!checkEmail) {
      print('Email is invalid');
      FlutterToastWidget().showMessage(Colors.red, 'Email is invalid');
      return;
    }

    if (!checkPassword) {
      print('Password does not match');
      FlutterToastWidget().showMessage(Colors.red, 'Password does not match');
      return;
    }

    if (!checkPasswordComplexity) {
      print('Password is not complex');
      FlutterToastWidget().showMessage(Colors.red, 'Password is not complex');
      return;
    }

    if (!checkIfUserExist) {
      print('Email already exists');
      FlutterToastWidget().showMessage(Colors.red, 'Email already exists');
      return;
    }

    if (!checkIfNameExist) {
      print('Name already exists');
      FlutterToastWidget().showMessage(Colors.red, 'Name already exists');
      return;
    }

    var userdata = {
      'email': emailController.text,
      'name': nameController.text,
      'role': selectedRole,
      'password': passwordController.text,
    };

    await userRepository.addUser(userdata);
    clearData();
  }

  // get user
  void _listenToUserStream() {
    userStream.listen((userList) {
      setUsers(userList);
      notifyListeners();
    });
  }

  // Filtered Search
  void filterUser(String query) {
    if (query.isNotEmpty) {
      filterUsers = users
          .where((user) =>
      user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filterUsers = users;
    }
    notifyListeners();
  }

  // Delete user
  Future<void> deleteUser(String uid, BuildContext context) async {
    SessionUtils sessionUtils = SessionUtils();

    var user = await sessionUtils.getUserInfo();
    var userID = user?['uid'];
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: 'Deleting User',
        surfaceTintColor: ColorUtils.primaryColor,
        barrierColor: Colors.black.withOpacity(0.5));

    try {
      if (userID == uid) {
        FlutterToastWidget().showMessage(Colors.red, 'You cannot delete your own account');
      } else {
        await userRepository.deleteUser(uid);
        FlutterToastWidget().showMessage(Colors.green, 'User deleted successfully');
      }
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }
}