import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/KidViewModel.dart';
import 'package:kapatidsync/src/widget/AddKidDialog.dart';
import 'package:provider/provider.dart';

import '../config/ColorUtils.dart';
import '../model/KidModel.dart';
import '../widget/AlertDialogOptionWidget.dart';

class KidUI extends StatelessWidget {
  const KidUI({super.key});

  @override
  Widget build(BuildContext context) {
    final KidViewModel viewModel = Provider.of<KidViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: const Text('List of Kids', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        )),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.005),
          Consumer<KidViewModel>(builder: (context, viewModel, child) {
            return Container(
              width: screenWidth * 0.99,
              height: screenHeight * 0.08,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent, width: 7),
              ),
              child: TextField(
                controller: viewModel.searchController,
                onChanged: (query) {
                  viewModel.filterUser(query);
                },
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent, width: 2),
                  ),
                  hintText: 'Search a kid....',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                ),
                style: const TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
          SizedBox(height: screenHeight * 0.005),
          Expanded(
            child: FutureBuilder(
              future: viewModel.kidsStream.first,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Consumer<KidViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.builder(
                        itemCount: viewModel.getKid.length,
                        itemBuilder: (context, index) {
                          KidModel user = viewModel.getKid[index];

                          return Card(
                            color: ColorUtils.primaryColor,
                            child: ListTile(
                              leading: Checkbox(
                                activeColor: ColorUtils.accentColor, // Background color of the checkbox
                                checkColor: ColorUtils.secondaryColor, // Color of the check
                                value: user.isSelected,
                                side: const BorderSide(color: ColorUtils.secondaryColor, width: 2.0), // Border color and width
                                onChanged: (bool? value) {
                                  user.isSelected = value ?? false;
                                  viewModel.notifyListeners();
                                },
                              ),
                              title: Text(
                                user.fullname,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'SmoochSans',
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Age: ${user.age}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'SmoochSans',
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Gender: ${user.gender}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'SmoochSans',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.white),
                                    onPressed: () {
                                      showDialog(context: context, builder: (BuildContext context) {
                                        return AlertDialogOptionWidget(
                                          title: 'Delete a kid',
                                          content: 'Are you sure you want to delete this kid?',
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ).build(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await viewModel.recordAttendance(context);
              },
              child: Text('Record Attendance'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.accentColor,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AddKidDialog();
          });
        },
        child: const Icon(Icons.add, color: ColorUtils.secondaryColor),
      ),
    );
  }
}