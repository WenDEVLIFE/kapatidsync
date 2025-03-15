import 'package:flutter/cupertino.dart';
import 'package:kapatidsync/src/Repositoryy/AttendanceRepository.dart';
import 'package:kapatidsync/src/model/AttendanceModel.dart';
import 'package:kapatidsync/src/model/KidModelII.dart';

class AttendanceViewModel extends ChangeNotifier {
  final TextEditingController attendanceSearchController = TextEditingController();
  final AttendanceRepository attendanceRepository = AttendanceRepositoryImpl();

  List<AttendanceModel> attendanceList = [];
  List<AttendanceModel> filteredAttendanceList = [];
  List<KidModelII> kidCollectionList = [];
  List<KidModelII> filteredKidCollectionList = [];

  List<AttendanceModel> get getAttendance => filteredAttendanceList;
  List<KidModelII> get getKidCollection => filteredKidCollectionList;

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
      setKidCollection(event);
      notifyListeners();
    });
  }

  void filterKid(String query) {
    if (query.isNotEmpty) {
      filteredKidCollectionList = kidCollectionList.where((kid) => kid.kidName.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredKidCollectionList = kidCollectionList;
    }
    notifyListeners();
  }

  void setKidCollection(List<KidModelII> event) {
    kidCollectionList = event;
    filteredKidCollectionList = kidCollectionList;
    notifyListeners();
  }

  double get presentPercentage {
    if (kidCollectionList.isEmpty) return 0.0;
    int presentCount = kidCollectionList.where((kid) => kid.isPresent == 'Present').length;
    return (presentCount / kidCollectionList.length) * 100;
  }

  double get absentPercentage {
    if (kidCollectionList.isEmpty) return 0.0;
    int absentCount = kidCollectionList.where((kid) => kid.isPresent == 'Absent').length;
    return (absentCount / kidCollectionList.length) * 100;
  }

  void deleteKid(String kidId, String attendanceId) {
    attendanceRepository.deleteKid(kidId, attendanceId);
  }
}