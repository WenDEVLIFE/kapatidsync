import 'package:flutter/cupertino.dart';

class KidViewModel extends ChangeNotifier {

  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController purokController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();

  var genderList = ['Male', 'Female'];
  var selectedGender ='Male';

  void filterUser(String query) {

  }

  void setGender(String? value) {
    selectedGender = value!;
    notifyListeners();
  }

  // TODO : implement add kid to the database



}