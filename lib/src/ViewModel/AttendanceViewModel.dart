import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/Repositoryy/AttendanceRepository.dart';
import 'package:kapatidsync/src/model/AttendanceModel.dart';
import 'package:kapatidsync/src/model/KidModel.dart';

class AttendanceViewModel extends ChangeNotifier {
  final TextEditingController attendanceSearchController = TextEditingController();
  final AttendanceRepository attendanceRepository = AttendanceRepositoryImpl();

  List<AttendanceModel> attendanceList = [];
  List<AttendanceModel> filteredAttendanceList = [];
  List<KidModel> kidCollectionList = [];
  List<KidModel> filteredKidCollectionList = [];

  List<AttendanceModel> get getAttendance => filteredAttendanceList;
  List<KidModel> get getKidCollection => filteredKidCollectionList;

  Stream<List<AttendanceModel>> get attendanceStream => attendanceRepository.getAttendance();

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

  void filterUser(String query) {
    if (query.isNotEmpty) {
      filteredAttendanceList = attendanceList.where((attendance) => attendance.attendanceName.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredAttendanceList = attendanceList;
    }
    notifyListeners();
  }

  void deleteAttendanceLogs(String id) {
    attendanceRepository.deleteAttendanceLogs(id);
  }

  void fetchKidCollection(String attendanceId) {
    attendanceRepository.getKidCollection(attendanceId).listen((event) {
      kidCollectionList = event;
      filteredKidCollectionList = kidCollectionList;
      notifyListeners();
    });
  }

  void filterKid(String query) {
    if (query.isNotEmpty) {
      filteredKidCollectionList = kidCollectionList.where((kid) => kid.fullname.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredKidCollectionList = kidCollectionList;
    }
    notifyListeners();
  }
}