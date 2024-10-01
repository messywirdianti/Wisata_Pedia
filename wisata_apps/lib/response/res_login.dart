// To parse this JSON data, do
//
//     final resLogin = resLoginFromJson(jsonString);

import 'dart:convert';

ResLogin resLoginFromJson(String str) => ResLogin.fromJson(json.decode(str));

String resLoginToJson(ResLogin data) => json.encode(data.toJson());

class ResLogin {
  int? value;
  String? message;
  String? username;
  String? password;
  String? id;

  ResLogin({
    this.value,
    this.message,
    this.username,
    this.password,
    this.id,
  });

  factory ResLogin.fromJson(Map<String, dynamic> json) => ResLogin(
    value: json["value"],
    message: json["message"],
    username: json["username"],
    password: json["password"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "username": username,
    "password": password,
    "id": id,
  };
}
