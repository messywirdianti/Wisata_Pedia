// To parse this JSON data, do
//
//     final resUpdateUser = resUpdateUserFromJson(jsonString);

import 'dart:convert';

ResUpdateUser resUpdateUserFromJson(String str) => ResUpdateUser.fromJson(json.decode(str));

String resUpdateUserToJson(ResUpdateUser data) => json.encode(data.toJson());

class ResUpdateUser {
  bool? isSuccess;
  int? value;
  String? message;
  String? username;
  String? fullname;
  String? gambar;
  String? id;

  ResUpdateUser({
    this.isSuccess,
    this.value,
    this.message,
    this.username,
    this.fullname,
    this.gambar,
    this.id,
  });

  factory ResUpdateUser.fromJson(Map<String, dynamic> json) => ResUpdateUser(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
    username: json["username"],
    fullname: json["fullname"],
    gambar: json["gambar"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
    "username": username,
    "fullname": fullname,
    "gambar": gambar,
    "id": id,
  };
}
