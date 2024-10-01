import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_apps/detail_wisata.dart';
import 'package:wisata_apps/response/res_get_wisata.dart';

import 'network.dart';

class MapWisata extends StatefulWidget {

  const MapWisata({super.key});

  @override
  State<MapWisata> createState() => _MapWisataState();
}

class _MapWisataState extends State<MapWisata> {
  List<Marker> _markers = [];
  List<DataWisata> listWisata = [];
  bool isWisata = false;

  Future<ResGetWisata?> getWisata() async {
    try {
      setState(() {
        isWisata = true;
      });
      http.Response res = await http.get(Uri.parse('${baseUrl}getWisata.php'));
      List<DataWisata>? data = resGetWisataFromJson(res.body).data;
      setState(() {
        isWisata = false;
        listWisata = data ?? [];
        // filterList = listWisata;
      });
    } catch (e, st) {
      setState(() {
        isWisata = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
        backgroundColor: Colors.red,
      ));
      log('st ${st.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    getWisata().then((e) {
      listWisata.forEach((eWisata){
        if (eWisata.latitud != null && eWisata.longitude != null) {
          print("ID Wisata: ${eWisata.id}");  // Cek apakah idWisata valid
          print("Nama Wisata: ${eWisata.namaWisata}");

          if (eWisata.id != null) {
            _markers.add(
              Marker(
                markerId: MarkerId(eWisata.id!),
                position: LatLng(
                    double.tryParse(eWisata.latitud ?? "") ?? 0.0,
                    double.tryParse(eWisata.longitude ?? "") ?? 0.0
                ),
                infoWindow: InfoWindow(
                    title: eWisata.namaWisata,
                    onTap: () {
                      Navigator.push(
                          context, 
                          MaterialPageRoute(
                              builder: (context) => DetailWisata(wisata: eWisata),
                          ),
                      );
              }
                ),
              ),
            );
          } else {
            print("Error: ID Wisata null untuk ${eWisata.namaWisata}");
          }
          
        }
      });

      // Update the state to reflect the new markers
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Wisata'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          zoom: 11.0,
          target: LatLng(1.1460220103493217, 104.0132105392135),
        ),
        markers: Set.from(_markers),
      ),
    );
  }
}
