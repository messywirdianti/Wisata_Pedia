// To parse this JSON data, do
//
//     final resGetWisata = resGetWisataFromJson(jsonString);

import 'dart:convert';

ResGetWisata resGetWisataFromJson(String str) => ResGetWisata.fromJson(json.decode(str));

String resGetWisataToJson(ResGetWisata data) => json.encode(data.toJson());

class ResGetWisata {
  bool? isSuccess;
  String? message;
  List<DataWisata>? data;

  ResGetWisata({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ResGetWisata.fromJson(Map<String, dynamic> json) => ResGetWisata(
    isSuccess: json["is_success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataWisata>.from(json["data"]!.map((x) => DataWisata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataWisata {
  String? id;
  String? namaWisata;
  String? kategori;
  String? gambarWisata;
  String? lokasi;
  String? latitud;
  String? longitude;

  DataWisata({
    this.id,
    this.namaWisata,
    this.kategori,
    this.gambarWisata,
    this.lokasi,
    this.latitud,
    this.longitude,
  });

  factory DataWisata.fromJson(Map<String, dynamic> json) => DataWisata(
    id: json["id"],
    namaWisata: json["nama_wisata"],
    kategori: json["kategori"],
    gambarWisata: json["gambar_wisata"],
    lokasi: json["lokasi"],
    latitud: json["latitud"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_wisata": namaWisata,
    "kategori": kategori,
    "gambar_wisata": gambarWisata,
    "lokasi": lokasi,
    "latitud": latitud,
    "longitude": longitude,
  };
}
