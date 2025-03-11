import 'package:flutter/cupertino.dart';

class KidViewModel extends ChangeNotifier {

  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController purokController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void filterUser(String query) {

  }
}