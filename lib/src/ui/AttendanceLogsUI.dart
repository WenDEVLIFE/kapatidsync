import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/ColorUtils.dart';
import '../model/AttendanceModel.dart';
import '../widget/AlertDialogOptionWidget.dart';
import '../ViewModel/AttendanceViewModel.dart';
import 'KidAttendanceUI.dart';

class AttendanceLogsUI extends StatelessWidget {
  const AttendanceLogsUI({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceViewModel viewModel = Provider.of<AttendanceViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: const SingleChildScrollView(
          child: Row(
            children: [
              Text('Attendance Logs', style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),),
            ],
          ),
        )
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.005),
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
                  viewModel.filterUser(query); // Call filterUser method
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
          SizedBox(height: screenHeight * 0.005),
          Expanded(
            child: FutureBuilder(
              future: viewModel.attendanceStream.first,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Consumer<AttendanceViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.getAttendance.isEmpty) {
                        return Center(
                          child: Text(
                            '${viewModel.attendanceSearchController.text} not found',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'SmoochSans',
                              color: Colors.black,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: viewModel.getAttendance.length,
                          itemBuilder: (context, index) {
                            AttendanceModel data = viewModel.getAttendance[index];

                            return Card(
                              color: ColorUtils.primaryColor,
                              child: ListTile(
                                title: Text(
                                  'Category Name: ${data.attendanceName}',
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
                                      'Date: ${data.attendanceDate}',
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
                                      icon: const Icon(Icons.remove_red_eye, color: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => KidCollectionUI(attendanceId: data.attendanceId, date: data.attendanceDate),
                                        ));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.white),
                                      onPressed: () {
                                        showDialog(context: context, builder: (BuildContext context) {
                                          return AlertDialogOptionWidget(
                                            title: 'Delete Attendance Logs',
                                            content: 'Are you sure you want to delete this attendance logs?',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              viewModel.deleteAttendanceLogs(data.attendanceId);
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
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}