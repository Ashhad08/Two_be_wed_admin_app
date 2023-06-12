// To parse this JSON data, do
//
//     final hallBookingModel = hallBookingModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'extra_service.dart';

HallBookingModel hallBookingModelFromJson(String str) =>
    HallBookingModel.fromJson(json.decode(str));

String hallBookingModelToJson(HallBookingModel data) =>
    json.encode(data.toJson(data.bookingId.toString()));

class HallBookingModel {
  String? bookingId;
  String? hallId;
  String? bookedBy;
  Timestamp? bookingDateTime;
  num? totalBudget;
  bool? isConfirmed;
  List<ExtraService>? bookedExtraServices;

  HallBookingModel({
    this.bookingId,
    this.hallId,
    this.bookedBy,
    this.bookingDateTime,
    this.totalBudget,
    this.isConfirmed,
    this.bookedExtraServices,
  });

  factory HallBookingModel.fromJson(Map<String, dynamic> json) =>
      HallBookingModel(
        bookingId: json["bookingId"],
        hallId: json["hallId"],
        bookedBy: json["bookedBy"],
        bookingDateTime: json["bookingDateTime"],
        totalBudget: json["totalBudget"],
        isConfirmed: json["isConfirmed"],
        bookedExtraServices: json["bookedExtraServices"] == null
            ? []
            : List<ExtraService>.from(json["bookedExtraServices"]!
                .map((x) => ExtraService.fromJson(x))),
      );

  Map<String, dynamic> toJson(String id) => {
        "bookingId": id,
        "hallId": hallId,
        "bookedBy": bookedBy,
        "bookingDateTime": bookingDateTime,
        "totalBudget": totalBudget,
        "isConfirmed": isConfirmed,
        "bookedExtraServices": bookedExtraServices == null
            ? []
            : List<dynamic>.from(bookedExtraServices!.map((x) => x.toJson())),
      };
}

// {
// "bookingId" : "",
// "hallId" : "",
// "bookedBy" : "",
// "bookingDateTime" : "",
// "totalBudget" : 0,
// "isConfirmed" : false,
// "BookedExtraServices" : [
// {
// "name" : "",
// "budget" : 0
// }
// ]
//
// }
