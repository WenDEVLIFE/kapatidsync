import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/KidViewModel.dart';
import 'package:kapatidsync/src/ViewModel/UserViewModel.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AddKidDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KidViewModel viewModel = Provider.of<KidViewModel>(context, listen: true);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: ColorUtils.primaryColor,
      title: const Text("Add a Kid"
          ,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          )
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Full Name',
                  hintStyle: TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.ageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Age',
                  hintStyle: TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.purokController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Purok Number',
                  hintStyle: TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.addressController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.birthdateController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    viewModel.birthdateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'BirthDate',
                  hintStyle: TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.contactController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  hintStyle: TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal:  10, vertical:  5),
              child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: ColorUtils.secondaryColor
                ),
                child: DropdownButton<String>(
                  value: viewModel.selectedGender,
                  items: viewModel.genderList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.white ,
                            fontFamily: 'Lato' ,
                            fontSize: 20 ,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    viewModel.setGender(value);
                  },
                  dropdownColor: ColorUtils.primaryColor,
                  iconEnabledColor: ColorUtils.accentColor,
                  style:  const TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400
                  ),
                  selectedItemBuilder: (BuildContext context){
                    return viewModel.genderList.map<Widget>((String item){
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(item,
                          style: const TextStyle(color: Colors.white ,
                              fontFamily: 'Lato' ,
                              fontSize: 20 ,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      );
                    }).toList();
                  },
                  isExpanded: true,
                  alignment: Alignment.bottomLeft,

                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.parentNameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Parent Name',
                  hintStyle: TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
           await viewModel.addKidEvent(context);
          },
          child: const Text("Add Kid",
            style: TextStyle(color: Colors.white ,
                fontFamily: 'Lato' ,
                fontSize: 20 ,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Cancel",
            style: TextStyle(color: Colors.white ,
                fontFamily: 'Lato' ,
                fontSize: 20 ,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
      ],
    );
  }


}