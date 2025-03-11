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
                controller: viewModel.nameController,
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
           /* ProgressDialog pd = ProgressDialog(context: context);
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


            */
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