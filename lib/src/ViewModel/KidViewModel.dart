import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../Repositoryy/KidRepository.dart';
import '../model/KidModel.dart';

class KidViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController purokController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();

  final KidRepository kidRepository = KidRepositoryImpl();

  var genderList = ['Male', 'Female'];
  var selectedGender = 'Male';

  List<KidModel> kids = [];
  KidModel? selectedKid;
  List<KidModel> filteredKids = [];

  List<KidModel> get getKid => filteredKids;

  Stream<List<KidModel>> get kidsStream => kidRepository.getKids();

  KidViewModel() {
    listenToUserStream();
  }

  void filterUser(String query) {
    if (query.isNotEmpty) {
      filteredKids = kids.where((kid) => kid.fullname.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredKids = kids;
    }
    notifyListeners();
  }

  void setGender(String? value) {
    selectedGender = value!;
    notifyListeners();
  }

  Future<void> addKidEvent(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Adding Kid...');
    try {
      if (nameController.text.isNotEmpty &&
          ageController.text.isNotEmpty &&
          purokController.text.isNotEmpty &&
          contactController.text.isNotEmpty &&
          birthdateController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          parentNameController.text.isNotEmpty) {
        Map<String, dynamic> kidData = {
          'name': nameController.text,
          'age': ageController.text,
          'purok': purokController.text,
          'contact': contactController.text,
          'birthdate': birthdateController.text,
          'address': addressController.text,
          'gender': selectedGender,
          'parentName': parentNameController.text,
        };

        await kidRepository.insertKid(kidData);
        clearData();
      } else {
        print('Please fill up all fields');
      }
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }

  void clearData() {
    nameController.clear();
    ageController.clear();
    purokController.clear();
    contactController.clear();
    birthdateController.clear();
    addressController.clear();
    parentNameController.clear();
    selectedGender = 'Male';
    notifyListeners();
  }

  void listenToUserStream() {
    kidsStream.listen((kidlist) {
      setKid(kidlist);
      notifyListeners();
    });
  }

  void setKid(List<KidModel> kidlist) {
    kids = kidlist;
    filteredKids = kids;
    notifyListeners();
  }

  Future<void> recordAttendance(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Recording Attendance...');
    try {
      await kidRepository.recordAttendance(getKid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Attendance recorded for all kids',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
      uncheckedAll();
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }

  void deleteKid(KidModel kid) {
    kidRepository.deleteKid(kid.id);
  }

  bool isAnyKidSelected() {
    return getKid.any((kid) => kid.isSelected);
  }

  void uncheckedAll() {
    getKid.forEach((kid) {
      kid.isSelected = false;
    });
    notifyListeners();
  }

  Future<void> addKidToAttendance(BuildContext context, String attendanceId, KidModel kid, TimeOfDay time, bool isAttended) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Adding Kid to Attendance...');
    try {
      await kidRepository.addKidToAttendance(attendanceId, kid, time, isAttended);
    } catch (e) {
      print(e);
    } finally {
      pd.close();
    }
  }

  void onChanged(String? value) {
    selectedGender = value!;
    notifyListeners();
  }
}