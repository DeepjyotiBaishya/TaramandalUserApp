import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ntp/ntp.dart';
import 'package:rashi_network/services/firebase/auth_servoces.dart';
import 'package:rashi_network/viewmodel/model/astrologer_model.dart';
import 'package:rashi_network/viewmodel/model/user_reports.dart';

class FirestoreSave {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var userAuth = AuthService().user!;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// daily new content when teacher required
  Future activeChat({
    required String astrologerUserID,
    required AstrologerProfileModel astrologerProfile,
    required UserReports userReports,
  }) async {
    final batch = _db.batch();
    DateTime ntp = await NTP.now();
    var ref = _db.collection("chat").doc(astrologerUserID);
    var data = {
      "name": userReports.user!.name,
      "userNToken": userReports.user!.nToken,
      "date": ntp.toString(),
      "live": true,
      "active": false,
      "id": astrologerProfile.id,
      "docID": ref.id,
    };
    batch.set(ref, data, SetOptions(merge: true));
    batch.commit();
  }
}
