import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/KidViewModel.dart';
import 'package:kapatidsync/src/ViewModel/UserViewModel.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:kapatidsync/src/widget/CustomDropdown.dart';
import 'package:kapatidsync/src/widget/CustomTextField.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'CustomDatePicker.dart';
import 'CustomText.dart';
import 'CustomTextButton.dart';

class AddKidDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KidViewModel viewModel = Provider.of<KidViewModel>(context, listen: true);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: ColorUtils.primaryColor,
      title:  const CustomText(fontSize: 20,
          text: 'Create a kid',
          color: ColorUtils.secondaryColor
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.nameController,
                screenHeight: screenHeight,
                hintText: 'Name',
                fontSize: 20,
                keyboardType: TextInputType.text
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.ageController,
                screenHeight: screenHeight,
                hintText: 'Age',
                fontSize: 20,
                keyboardType: TextInputType.number
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.purokController,
                screenHeight: screenHeight,
                hintText: 'Purok Number',
                fontSize: 20,
                keyboardType: TextInputType.text
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.addressController,
                screenHeight: screenHeight,
                hintText: 'Address',
                fontSize: 20,
                keyboardType: TextInputType.streetAddress
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomDatePicker(
              screenWidth: screenWidth,
              controller: viewModel.birthdateController,
              hintText: 'BirthDate',
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.contactController,
                screenHeight: screenHeight,
                hintText: 'Contact Number',
                fontSize: 20,
                keyboardType: TextInputType.number
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomDropdown<String>(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              selectedItem: viewModel.selectedGender,
              itemList: viewModel.genderList,
              onChanged: viewModel.onChanged,
              itemLabel: (String value) => value,
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.parentNameController,
                screenHeight: screenHeight,
                hintText: 'Parent Name',
                fontSize: 20,
                keyboardType: TextInputType.text
            )
          ],
        ),
      ),
      actions: [
        CustomTextButton(
            fontSize: 20,
            text: 'Add Kid',
            color: Colors.white,
            onPressed: () async {
              await viewModel.addKidEvent(context);
            }
        ),
        CustomTextButton(
            fontSize: 20,
            text: 'Cancel',
            color: Colors.white,
            onPressed: () async {
              Navigator.pop(context);
            }
        ),
      ],
    );
  }


}