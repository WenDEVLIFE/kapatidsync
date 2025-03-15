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

  void attendanceListen() {
    attendanceStream.listen((event) {
      attendanceList = event;
      filteredAttendanceList = attendanceList;
      notifyListeners();
    });
  }


}