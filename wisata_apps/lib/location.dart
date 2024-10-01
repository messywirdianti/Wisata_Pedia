import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Location extends StatelessWidget {
  final LatLng lokasi;
  final String namaWisata;
  const Location({required this.namaWisata,required this.lokasi, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: lokasi,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId(namaWisata),
            position: lokasi,
            infoWindow: InfoWindow(title: namaWisata),
          )
        },
      ),
    );
  }
}
