import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/ColorUtils.dart';
import '../model/KidModel.dart';
import '../widget/AlertDialogOptionWidget.dart';
import '../ViewModel/AttendanceViewModel.dart';

class KidCollectionUI extends StatefulWidget {
  final String attendanceId;

  KidCollectionUI({required this.attendanceId});

  @override
  _KidCollectionUIState createState() => _KidCollectionUIState();
}

class _KidCollectionUIState extends State<KidCollectionUI> {
  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<AttendanceViewModel>(context, listen: false);
    viewModel.fetchKidCollection(widget.attendanceId); // Fetch KidCollection data
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        title: const Text('Date', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
        ),),
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
                  if (viewModel.getKidCollection.isEmpty){
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
                  } else{
                    return ListView.builder(
                      itemCount: viewModel.getKidCollection.length,
                      itemBuilder: (context, index, ) {
                        KidModel kid = viewModel.getKidCollection[index];
                        return Card(
                          color: ColorUtils.primaryColor,
                          child: ListTile(
                            title: Text(
                              kid.fullname,
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
                                  'Date: ${kid.birthdate}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'SmoochSans',
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Age: ${kid.age}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'SmoochSans',
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Purok: ${kid.purok}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'SmoochSans',
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Contact Number: ${kid.phoneNumber}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'SmoochSans',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                showDialog(context: context, builder: (BuildContext context) {
                                  return AlertDialogOptionWidget(
                                    title: 'Delete ${kid.fullname}',
                                    content: 'Are you sure you want to delete ${kid.fullname}?',
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Add delete functionality here
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
        ],
      ),
    );
  }
}