import 'dart:async'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';
import 'package:rashi_network/services/firebase/auth_servoces.dart'; 
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User userAuth = AuthService().user!;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//  /// Notification For My Schools
//   Stream<List<NotificationModel>> notificationForSchools(String schoolName) {
//     var ref = _db
//         .collection("mySchool")
//         .doc(schoolName)
//         .collection("notifications")
//         // .where("whereNotification", whereIn: ["field", "field2", "field3"])
//         // .orderBy("date", descending: false)
//         .snapshots();
//     var data = ref.map((snapShot) => snapShot.docs
//         .map((document) =>
//             NotificationModel.fromJson(document.data(), document.id))
//         .toList());
//     return data;
//   }

}
