import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wisata_apps/location.dart';
import 'package:wisata_apps/network.dart';
import 'package:wisata_apps/response/res_get_wisata.dart';

import 'edit_wisata.dart';

class DetailWisata extends StatelessWidget {
  final DataWisata wisata;
  const DetailWisata({super.key, required this.wisata});

  @override
  Widget build(BuildContext context) {
    LatLng lokasi = LatLng(
        double.tryParse(wisata.latitud ?? "") ?? 0.0,
        double.tryParse(wisata.longitude ?? "") ?? 0.0
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Wisata"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
              child: Image.network('$imageUrl${wisata.gambarWisata}',
              height: 300,
              fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
              ),
              ),
              Positioned(
                top: 300,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${wisata.namaWisata ?? 'Nama Wisata Tidak Tersedia'}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Icon(Icons.star_rate_sharp, color: Colors.amber, size: 20),
                          Text('4.8'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Kategori Wisata: ${wisata.kategori ?? 'Kategori Tidak Tersedia'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Lokasi: ${wisata.lokasi ?? 'Lokasi Wisata Tidak Tersedia'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Location(
                          namaWisata: wisata.namaWisata ?? 'Nama Tidak Tersedia',
                          lokasi: lokasi,
                      ),
                      const SizedBox(height: 10),
                      Center(
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => EditWisata(wisata),
                                )
                            );
                          },
                          child: const Text('Edit'),
                          textColor: Colors.white,
                          color: Colors.indigoAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

