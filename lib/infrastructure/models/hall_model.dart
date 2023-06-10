// To parse this JSON data, do
//
//     final hallModel = hallModelFromJson(jsonString);

import 'dart:convert';

import 'extra_service.dart';

HallModel hallModelFromJson(String str) => HallModel.fromJson(json.decode(str));

String hallModelToJson(HallModel data) =>
    json.encode(data.toJson(data.hallId.toString()));

class HallModel {
  String? hallId;
  String? adminId;
  String? name;
  String? description;
  num? budget;
  num? capacity;
  String? address;
  String? phoneNumber;
  String? firstImage;
  String? secondImage;
  String? thirdImage;
  String? fourthImage;
  List<ExtraService>? extraServices;

  HallModel({
    this.hallId,
    this.name,
    this.description,
    this.budget,
    this.capacity,
    this.address,
    this.phoneNumber,
    this.firstImage,
    this.secondImage,
    this.thirdImage,
    this.fourthImage,
    this.extraServices,
    this.adminId,
  });

  factory HallModel.fromJson(Map<String, dynamic> json) => HallModel(
        hallId: json["hallId"],
        adminId: json["adminId"],
        name: json["name"],
        description: json["description"],
        budget: json["budget"],
        capacity: json["capacity"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        firstImage: json["firstImage"],
        secondImage: json["secondImage"],
        thirdImage: json["thirdImage"],
        fourthImage: json["fourthImage"],
        extraServices: List<ExtraService>.from(
            json["extraServices"].map((x) => ExtraService.fromJson(x))),
      );

  Map<String, dynamic> toJson(String id) => {
        "hallId": id,
        "adminId": adminId,
        "name": name,
        "description": description,
        "budget": budget,
        "capacity": capacity,
        "address": address,
        "phoneNumber": phoneNumber,
        "firstImage": firstImage,
        "secondImage": secondImage,
        "thirdImage": thirdImage,
        "fourthImage": fourthImage,
        "extraServices":
            List<dynamic>.from(extraServices!.map((x) => x.toJson())),
      };
}
// {
// "hallId" : "",
// "name" : "",
// "description" : "",
// "budget" : 0,
// "capacity" : 0,
// "address" : "",
// "phoneNumber" : 0,
// "FirstImage" : "",
// "secondImage" : "",
// "thirdImage" : "",
// "fourthImage" : "",
// "extraServices" : [
// {
// "name" : "",
// "budget" : 0
// }
// ]
// }
