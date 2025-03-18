import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../ViewModel/AttendanceViewModel.dart';
import '../config/ColorUtils.dart';
import '../model/KidModelII.dart';
import '../widget/AddAttendanceKidDialog.dart';
import '../widget/AlertDialogOptionWidget.dart';
import '../services/ExcelService.dart';
import '../widget/CustomText.dart';

class KidCollectionUI extends StatefulWidget {
  final String attendanceId;
  final String date;

  KidCollectionUI({required this.attendanceId, required this.date});

  @override
  _KidCollectionUIState createState() => _KidCollectionUIState();
}

class _KidCollectionUIState extends State<KidCollectionUI> {
  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<AttendanceViewModel>(context, listen: false);
    viewModel.fetchKidCollection(widget.attendanceId); // Fetch KidCollection data
    widget.date;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: CustomText(fontSize: 18,
            text:      'Attendance Logs for ${widget.date}',
            color: ColorUtils.secondaryColor
        ),
      ),
      body: Column(
        children: [
          Consumer<AttendanceViewModel>(builder: (context, viewModel, child) {
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
                controller: viewModel.attendanceSearchController,
                onChanged: (query) {
                  viewModel.filterKid(query);
                },
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent, width: 2),
                  ),
                  hintText: 'Search attendance logs...',
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
          Expanded(
            child: Consumer<AttendanceViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.getKidCollection.isEmpty) {
                  return Center(
                    child:CustomText(fontSize: 18,
                        text: '${viewModel.attendanceSearchController.text} not found',
                        color: ColorUtils.secondaryColor
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: viewModel.getKidCollection.length,
                    itemBuilder: (context, index) {
                      KidModelII kid = viewModel.getKidCollection[index];
                      return Card(
                        color: ColorUtils.primaryColor,
                        child: ListTile(
                          title:  CustomText(fontSize: 18,
                              text: kid.kidName,
                              color: ColorUtils.secondaryColor
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(fontSize: 16,
                                  text: 'Age: ${kid.kidAge}',
                                  color: ColorUtils.secondaryColor
                              ),
                              CustomText(fontSize: 16,
                                  text:   'Gender: ${kid.kidGender}',
                                  color: ColorUtils.secondaryColor
                              ),
                              CustomText(fontSize: 16,
                                  text: 'Purok: ${kid.kidPurok}',
                                  color: ColorUtils.secondaryColor
                              ),
                              CustomText(fontSize: 16,
                                  text: kid.isPresent == 'Present' ? 'Present' : 'Absent',
                                  color: ColorUtils.secondaryColor
                              ),
                              CustomText(fontSize: 16,
                                  text: kid.isPresent == 'Present' ? 'Time In: ${kid.kidTimeIn}' : '',
                                  color: ColorUtils.secondaryColor
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              showDialog(context: context, builder: (BuildContext context) {
                                return AlertDialogOptionWidget(
                                  title: 'Delete ${kid.kidName}',
                                  content: 'Are you sure you want to delete ${kid.kidName}?',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    viewModel.deleteKid(kid.kidId, widget.attendanceId);
                                  },
                                ).build(context);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Consumer<AttendanceViewModel>(
            builder: (context, viewModel, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(fontSize: 16,
                        text: 'Present: ${viewModel.presentPercentage.toStringAsFixed(2)}%',
                        color: ColorUtils.primaryColor
                    ),
                    CustomText(fontSize: 16,
                        text: 'Absent: ${viewModel.absentPercentage.toStringAsFixed(2)}%',
                        color: ColorUtils.accentColor
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0, color: ColorUtils.secondaryColor),
        backgroundColor: ColorUtils.primaryColor,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add, color: ColorUtils.secondaryColor,),
            backgroundColor: ColorUtils.primaryColor,
            label: 'Add Kid to Attendance',
            labelStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'SmoochSans',
              color: Colors.black,
            ),
            onTap: () {
              showDialog(context: context, builder: (BuildContext context) {
                return AddAttendanceKidDialog(attendanceId: widget.attendanceId);
              });

            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.print,color: ColorUtils.secondaryColor),
            backgroundColor: ColorUtils.primaryColor,
            label: 'Save Attendance',
            labelStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'SmoochSans',
              color: Colors.black,
            ),
            onTap: () async {
              final viewModel = Provider.of<AttendanceViewModel>(context, listen: false);
              final excelService = ExcelService();
              await excelService.saveKidCollectionToExcel(viewModel.getKidCollection, widget.date);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Attendance saved to Excel'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}