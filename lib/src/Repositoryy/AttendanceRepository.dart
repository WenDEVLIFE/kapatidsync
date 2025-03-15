import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapatidsync/src/model/AttendanceModel.dart';

abstract class AttendanceRepository {
 Stream<List<AttendanceModel>> getAttendance();
 Future<void> deleteAttendanceLogs(String id);
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Get the attendance list
  @override
  Stream<List<AttendanceModel>> getAttendance() {
    return firebaseFirestore.collection('attendancecollection').snapshots().map((snapshot) => snapshot.docs.map((doc) => AttendanceModel.fromDocumentSnapShot(doc)).toList());
  }

  // Delete the attendance logs
  @override
  Future<void> deleteAttendanceLogs(String id) {
    return firebaseFirestore.collection('attendancecollection').doc(id).delete();
  }

}