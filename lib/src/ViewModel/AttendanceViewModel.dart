import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/Repositoryy/AttendanceRepository.dart';
import 'package:kapatidsync/src/model/AttendanceModel.dart';

class AttendanceViewModel extends ChangeNotifier {
  final TextEditingController attendanceSearchController = TextEditingController();

  final AttendanceRepository attendanceRepository = AttendanceRepositoryImpl();

  List<AttendanceModel> attendanceList = [];
  List <AttendanceModel> filteredAttendanceList = [];

  List<AttendanceModel> get getAttendance => filteredAttendanceList;

  Stream <List <AttendanceModel>> get attendanceStream => attendanceRepository.getAttendance();

  AttendanceViewModel() {
    attendanceListen();
  }

  // Listen to the attendance logs
  void attendanceListen() {
    attendanceStream.listen((event) {
      attendanceList = event;
      filteredAttendanceList = attendanceList;
      notifyListeners();
    });
  }

  // Filter the attendance logs
  void filterUser(String query) {
   if (query.isNotEmpty) {
     filteredAttendanceList = attendanceList.where((attendance) => attendance.attendanceName.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredAttendanceList = attendanceList;
   }
    notifyListeners();
  }

  // Delete the attendance logs
  void deleteAttendanceLogs(String id) {
    attendanceRepository.deleteAttendanceLogs(id);
  }


}