import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String attendanceId;
  final String attendanceName;
  final String attendanceDate;

  AttendanceModel({
    required this.attendanceId,
    required this.attendanceName,
    required this.attendanceDate,
  });

  factory AttendanceModel.fromDocumentSnapShot(DocumentSnapshot doc) {
    return AttendanceModel(
      attendanceId: doc.id,
      attendanceName: doc['Category'],
      attendanceDate: doc['Date'].toDate().toString(),
    );
  }
}