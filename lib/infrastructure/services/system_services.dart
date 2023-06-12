import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_be_wedd/infrastructure/models/admin_model.dart';
import 'package:two_be_wedd/infrastructure/models/hall_booking_model.dart';
import 'package:two_be_wedd/infrastructure/models/hall_model.dart';
import 'package:two_be_wedd/infrastructure/models/user_model.dart';
import 'package:two_be_wedd/utils/backend_configs.dart';

class SystemServices {
  Stream<HallModel> fetchCurrentAdminHall() {
    return BackEndConfigs.hallsCollectionsRef
        .where("adminId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs
            .map((e) => HallModel.fromJson(e.data() as Map<String, dynamic>))
            .first);
  }

  Stream<AdminModel> fetchCurrentAdmin() {
    return BackEndConfigs.adminsCollectionsRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) =>
            AdminModel.fromJson(event.data() as Map<String, dynamic>));
  }

  Stream<List<HallBookingModel>> fetchCurrentAdminBookings(String hallId) {
    return BackEndConfigs.hallBookingsCollectionRef
        .where("hallId", isEqualTo: hallId)
        .where("isConfirmed", isEqualTo: false)
        .orderBy("bookingDateTime", descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                HallBookingModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<HallBookingModel>> fetchCurrentAdminConfirmOrders(String hallId) {
    return BackEndConfigs.hallBookingsCollectionRef
        .where("hallId", isEqualTo: hallId)
        .where("isConfirmed", isEqualTo: true)
        .orderBy("bookingDateTime", descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) =>
                HallBookingModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<int> fetchNumberOfBookings(String hallId) {
    return BackEndConfigs.hallBookingsCollectionRef
        .where("hallId", isEqualTo: hallId)
        .where("isConfirmed", isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<int> fetchNumberOfConfirmOrders(String hallId) {
    return BackEndConfigs.hallBookingsCollectionRef
        .where("hallId", isEqualTo: hallId)
        .where("isConfirmed", isEqualTo: true)
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<UserModel> fetchSpecificUser(String uid) {
    return BackEndConfigs.usersCollectionsRef.doc(uid).snapshots().map(
        (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }

  Future<void> sendPushNotification({
    required String token,
    required String date,
    required String hallName,
  }) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization":
                "key=AAAAfXNlwzc:APA91bGVlLEDj8kdsBapn_w5UTnImGHOUWsww-OvHq30iR91Kc-LuY2ENd4hnH534mbBZgCZFmKB5i5ZfXvktj9nBODSObReYxkEvmyI1aa4Agwe4Y2uMFIIbVAkpYoxjT5uWz6P2Mwp"
          },
          body: jsonEncode(<String, dynamic>{
            "to": token,
            "notification": {
              "body": "Your booking of $hallName is been confirmed.",
              "title": "Booking Confirmed on $date",
              "android_channel_id": "twoBeWedd",
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "sound": true
            },
            "priority": "high",
          }));
    } catch (e) {
      debugPrint("sendPushNotificationError :${e.toString()}");
    }
  }
}
