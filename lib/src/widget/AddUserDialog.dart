import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/UserViewModel.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'CustomPasswordTextField.dart';
import 'CustomText.dart';
import 'CustomTextButton.dart';
import 'CustomTextField.dart';

class AddUserDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel viewModel = Provider.of<UserViewModel>(context, listen: true);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: ColorUtils.primaryColor,
      title: const CustomText(fontSize: 20,
          text: 'Create User',
          color: ColorUtils.secondaryColor
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.emailController,
                screenHeight: screenHeight,
                hintText: 'Email',
                fontSize: 20,
                keyboardType: TextInputType.text
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                controller: viewModel.nameController,
                screenHeight: screenHeight,
                hintText: 'Name',
                fontSize: 20,
                keyboardType: TextInputType.text
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomPasswordTextField(screenHeight: screenHeight,
              hintText: 'Password',
              controller: viewModel.passwordController,
              isPasswordVisible: viewModel.isObscure1,
              togglePasswordVisibility: viewModel.toggleObscureText1,
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomPasswordTextField(screenHeight: screenHeight,
              hintText: 'Confirm Password',
              controller: viewModel.confirmPasswordController,
              isPasswordVisible: viewModel.isObscure2,
              togglePasswordVisibility: viewModel.toggleObscureText2,
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
                  value: viewModel.selectedRole,
                  items: viewModel.role.map<DropdownMenuItem<String>>((String value){
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
                    viewModel.setRole(value);
                },
                  dropdownColor: ColorUtils.primaryColor,
                  iconEnabledColor: ColorUtils.accentColor,
                  style:  const TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400
                  ),
                  selectedItemBuilder: (BuildContext context){
                    return viewModel.role.map<Widget>((String item){
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
          ],
        ),
      ),
      actions: [
        CustomTextButton(
            fontSize: 20,
            text: 'Adding User',
            color: Colors.white,
            onPressed: () async {
              ProgressDialog pd = ProgressDialog(context: context);
              pd.show(max: 100, msg: 'Adding User');

              try{
                await viewModel.addUser();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } catch (e){
                print(e);
              }finally{
                pd.close();
              }
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