import 'package:cloud_firestore/cloud_firestore.dart';

class KidModelII {
  final String kidId;
  final String kidName;
  final String kidAge;
  final String kidGender;
  final String kidPurok;
  final String kidDateIn;
  final String kidTimeIn;
  final String isPresent;

  KidModelII({
    required this.kidId,
    required this.kidName,
    required this.kidAge,
    required this.kidGender,
    required this.kidPurok,
    required this.kidDateIn,
    required this.kidTimeIn,
    required this.isPresent,
  });

  factory KidModelII.fromDocumentSnapShot(DocumentSnapshot doc) {
    return KidModelII(
      kidId: doc.id,
      kidName: doc['Name'],
      kidAge: doc['Age'],
      kidGender: doc['Gender'],
      kidPurok: doc['Purok'],
      kidDateIn: doc['DateIn'],
      kidTimeIn: doc['TimeIn'],
      isPresent: doc['isAttended'] == true ? 'Present' : 'Absent',
    );
  }
}