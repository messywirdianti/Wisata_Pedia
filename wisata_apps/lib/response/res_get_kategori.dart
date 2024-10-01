// To parse this JSON data, do
//
//     final resGetKategori = resGetKategoriFromJson(jsonString);

import 'dart:convert';

ResGetKategori resGetKategoriFromJson(String str) => ResGetKategori.fromJson(json.decode(str));

String resGetKategoriToJson(ResGetKategori data) => json.encode(data.toJson());

class ResGetKategori {
  bool? isSuccess;
  String? message;
  List<DataKategori>? data;

  ResGetKategori({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ResGetKategori.fromJson(Map<String, dynamic> json) => ResGetKategori(
    isSuccess: json["is_success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataKategori>.from(json["data"]!.map((x) => DataKategori.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataKategori {
  String? id;
  String? kategori;

  DataKategori({
    this.id,
    this.kategori,
  });

  factory DataKategori.fromJson(Map<String, dynamic> json) => DataKategori(
    id: json["id"],
    kategori: json["kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kategori": kategori,
  };
}
