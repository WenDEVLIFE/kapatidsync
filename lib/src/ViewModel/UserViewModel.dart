import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/Repositoryy/UserRepository.dart';
import 'package:kapatidsync/src/config/CheckDataUtils.dart';
import 'package:kapatidsync/src/widget/FlutterToastWidget.dart';

class UserViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final CheckDataUtils checkDataUtils = CheckDataUtils();
  final UserRepository userRepository = UserRepositoryImpl();

  bool obscureText1 = true;
  bool obscureText2 = true;

  bool get isObscure1 => obscureText1;
  bool get isObscure2 => obscureText2;

  var role = ['Admin', 'Chruch Officer'];
  var selectedRole ='Admin';

  void toggleObscureText1() {
    obscureText1 = !obscureText1;
    notifyListeners();
  }

  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }


  void setRole(String? value) {
    selectedRole = value!;
    notifyListeners();
  }

  void clearData(){
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedRole = 'Admin';
  }

  Future<void> addUser() async {

    bool checkEmail = await checkDataUtils.validateEmail(emailController.text);
    bool checkPassword = await checkDataUtils.checkPassword(passwordController.text, confirmPasswordController.text);
    bool checkPasswordComplexity = await checkDataUtils.checkPasswordComplexity(passwordController.text);
    bool checkIfUserExist = await checkDataUtils.checkIfUserExist(emailController.text);
    bool checkIfNameExist = await checkDataUtils.checkIfNameExist(nameController.text);

    if (emailController.text.isEmpty){
      print('Email is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Email is empty');
    }

    if (passwordController.text.isEmpty){
      print('Password is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Password is empty');
    }

    if (confirmPasswordController.text.isEmpty){
      print('Confirm Password is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Confirm Password is empty');
    }

    if (nameController.text.isEmpty){
      print('Name is empty');
      FlutterToastWidget().showMessage(Colors.red, 'Name is empty');
    }

    if (checkEmail == false){
      print('Email is invalid');
      FlutterToastWidget().showMessage(Colors.red, 'Email is invalid');
    }

    if (checkPassword == false){
      print('Password does not match');
      FlutterToastWidget().showMessage(Colors.red, 'Password does not match');

    }

    if (checkPasswordComplexity == false){
      print('Password is not complex');
      FlutterToastWidget().showMessage(Colors.red, 'Password is not complex');
    }

    if (checkIfUserExist == false){
      print('Email already exist');
      FlutterToastWidget().showMessage(Colors.red, 'Email already exist');

    }

    if (checkIfNameExist == false){
      print('Name already exist');
      FlutterToastWidget().showMessage(Colors.red, 'Name already exist');
    }

    else{

      var userdata = {
        'email': emailController.text,
        'name': nameController.text,
        'role': selectedRole,
        'password': passwordController.text,
      };

      await userRepository.addUser(userdata);
      clearData();
    }

  }

}