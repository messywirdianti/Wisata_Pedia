// To parse this JSON data, do
//
//     final resUser = resUserFromJson(jsonString);

import 'dart:convert';

ResUser resUserFromJson(String str) => ResUser.fromJson(json.decode(str));

String resUserToJson(ResUser data) => json.encode(data.toJson());

class ResUser {
  bool? isSuccess;
  String? message;
  List<DataUser>? data;

  ResUser({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ResUser.fromJson(Map<String, dynamic> json) => ResUser(
    isSuccess: json["is_success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataUser>.from(json["data"]!.map((x) => DataUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataUser {
  String? id;
  String? username;
  String? fullname;
  String? password;
  DateTime? tglDaftar;
  String? gambarUser;

  DataUser({
    this.id,
    this.username,
    this.fullname,
    this.password,
    this.tglDaftar,
    this.gambarUser,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
    id: json["id"],
    username: json["username"],
    fullname: json["fullname"],
    password: json["password"],
    tglDaftar: json["tgl_daftar"] == null ? null : DateTime.parse(json["tgl_daftar"]),
    gambarUser: json["gambar_user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fullname": fullname,
    "password": password,
    "tgl_daftar": tglDaftar?.toIso8601String(),
    "gambar_user": gambarUser,
  };
}
