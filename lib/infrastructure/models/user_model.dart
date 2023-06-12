// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? notificationToken;
  String? phoneNumber;
  String? profileImage;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.notificationToken,
    this.phoneNumber,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
        notificationToken: json["notificationToken"],
        phoneNumber: json["phoneNumber"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "notificationToken": notificationToken,
        "phoneNumber": phoneNumber,
        "profileImage": profileImage,
      };
}
// {
// "uid" : "",
// "email" : "",
// "name" : "",
// "notificationToken" : "",
// "phoneNumber" : "",
// "profileImage" : ""
// }
