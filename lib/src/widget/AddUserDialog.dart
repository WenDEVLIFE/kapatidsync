import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/UserViewModel.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AddUserDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserViewModel viewModel = Provider.of<UserViewModel>(context, listen: true);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return AlertDialog(
      backgroundColor: ColorUtils.primaryColor,
      title: const Text("Add User"
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
               controller: viewModel.emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Email',
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
                controller: viewModel.nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Name',
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
                controller: viewModel.passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: viewModel.isObscure1,
                decoration: InputDecoration(
                  hintText: 'Password' ,
                  hintStyle: const TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(viewModel.isObscure1 ? Icons.visibility : Icons.visibility_off),
                    color: Colors.white,
                    onPressed: () {
                      viewModel.toggleObscureText1();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: screenWidth * 0.8,
              child: TextField(
                controller: viewModel.confirmPasswordController,
                style: const TextStyle(color: Colors.white),
                obscureText: viewModel.isObscure2,
                decoration: InputDecoration(
                  hintText: 'Confirm Password' ,
                  hintStyle: const TextStyle(color: Colors.white ,
                      fontFamily: 'Lato' ,
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(viewModel.isObscure2 ? Icons.visibility : Icons.visibility_off),
                    color: Colors.white,
                    onPressed: () {
                      viewModel.toggleObscureText2();
                    },
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
        TextButton(
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
          },
          child: Text("Add User",
          style: const TextStyle(color: Colors.white ,
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
          child: Text("Cancel",
            style: const TextStyle(color: Colors.white ,
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