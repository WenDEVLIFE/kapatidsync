import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapatidsync/src/model/KidModel.dart';

import '../model/AttendanceModel.dart';

abstract class AttendanceRepository {
  Stream<List<AttendanceModel>> getAttendance();
  Future<void> deleteAttendanceLogs(String id);
  Stream<List<KidModel>> getKidCollection(String attendanceId); // New method
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<AttendanceModel>> getAttendance() {
    return firebaseFirestore.collection('attendancecollection').snapshots().map((snapshot) => snapshot.docs.map((doc) => AttendanceModel.fromDocumentSnapShot(doc)).toList());
  }

  @override
  Future<void> deleteAttendanceLogs(String id) {
    return firebaseFirestore.collection('attendancecollection').doc(id).delete();
  }

  @override
  Stream<List<KidModel>> getKidCollection(String attendanceId) {
    return firebaseFirestore
        .collection('attendancecollection')
        .doc(attendanceId)
        .collection('KidCollection')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => KidModel.fromDocumentSnapShot(doc)).toList());
  }
}