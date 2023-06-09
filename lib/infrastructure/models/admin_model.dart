// To parse this JSON data, do
//
//     final AdminModel = AdminModelFromJson(jsonString);

import 'dart:convert';

AdminModel adminModelFromJson(String str) =>
    AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  String id;
  String email;
  String name;
  String notificationToken;

  AdminModel({
    required this.id,
    required this.email,
    required this.name,
    required this.notificationToken,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        notificationToken: json["notificationToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "notificationToken": notificationToken,
      };
}
