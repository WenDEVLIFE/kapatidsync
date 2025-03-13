import 'package:flutter/cupertino.dart';
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
  var selectedGender ='Male';

  List<KidModel> kids = [];
  List<KidModel> filteredKids = [];

  Stream<List<KidModel>> get kidsStream => kidRepository.getKids();


  void filterUser(String query) {

  }

  void setGender(String? value) {
    selectedGender = value!;
    notifyListeners();
  }


  Future<void> addKidEvent(BuildContext context) async{
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Adding Kid...');
    try{
      if (nameController.text.isNotEmpty && ageController.text.isNotEmpty && purokController.text.isNotEmpty && contactController.text.isNotEmpty && birthdateController.text.isNotEmpty && addressController.text.isNotEmpty && parentNameController.text.isNotEmpty){
        Map<String, dynamic> kidData = {
          'name': nameController.text,
          'age': ageController.text,
          'purok': purokController.text,
          'contact': contactController.text,
          'birthdate': birthdateController.text,
          'address': addressController.text,
          'parentName': parentNameController.text,
        };

        await kidRepository.insertKid(kidData);
        clearData();
      }
      else{
        print('Please fill up all fields');
      }

    }catch (e){
      print(e);
    }
    finally{
      pd.close();
    }

  }

  void clearData(){
    nameController.clear();
    ageController.clear();
    purokController.clear();
    contactController.clear();
    birthdateController.clear();
    addressController.clear();
    parentNameController.clear();
    selectedGender ='Male';
    notifyListeners();
  }



}