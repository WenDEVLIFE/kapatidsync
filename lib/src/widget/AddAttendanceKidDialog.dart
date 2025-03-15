import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapatidsync/src/ViewModel/KidViewModel.dart';
import 'package:kapatidsync/src/config/ColorUtils.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../model/KidModel.dart';

class AddAttendanceKidDialog extends StatefulWidget {
  final String attendanceId;

  const AddAttendanceKidDialog({Key? key, required this.attendanceId}) : super(key: key);

  @override
  KidState createState() => KidState();
}

class KidState extends State<AddAttendanceKidDialog> {
  List<String> isAttended = ['Present', 'Absent'];
  String? selectedKid;
  String selectedAttendance = 'Present';
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    final KidViewModel viewModel = Provider.of<KidViewModel>(context, listen: false);
    viewModel.listenToUserStream();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final KidViewModel viewModel = Provider.of<KidViewModel>(context, listen: true);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: ColorUtils.primaryColor,
      title: const Text(
        "Add a Kid to the attendance list",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: ColorUtils.secondaryColor),
                child: DropdownButton<String>(
                  value: selectedAttendance,
                  items: isAttended.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedAttendance = value!;
                    });
                  },
                  dropdownColor: ColorUtils.primaryColor,
                  iconEnabledColor: ColorUtils.accentColor,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return isAttended.map<Widget>((String item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
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
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: ColorUtils.secondaryColor),
                child: DropdownButton<String>(
                  value: selectedKid,
                  items: viewModel.kids.map<DropdownMenuItem<String>>((KidModel kid) {
                    return DropdownMenuItem(
                      value: kid.fullname,
                      child: Text(
                        kid.fullname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedKid = value;
                    });
                  },
                  dropdownColor: ColorUtils.primaryColor,
                  iconEnabledColor: ColorUtils.accentColor,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return viewModel.kids.map<Widget>((KidModel kid) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          kid.fullname,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
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
            if (selectedAttendance == 'Present')
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.08,
                decoration: const BoxDecoration(
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorUtils.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _selectTime(context),
                  child: Text(
                    "Select Time: ${selectedTime.format(context)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
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
            if (selectedKid != null) {
              KidModel selectedKidModel = viewModel.kids.firstWhere((kid) => kid.fullname == selectedKid);
              await viewModel.addKidToAttendance(
                context,
                widget.attendanceId,
                selectedKidModel,
                selectedTime,
                selectedAttendance == 'Present',
              );
            }
          },
          child: const Text(
            "Add Attendance",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        TextButton(
          onPressed: () {

            // TODO: Add a save the attendance on a excel file
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}