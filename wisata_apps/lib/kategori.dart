// import 'package:flutter/material.dart';
// import 'package:wisata_apps/list_wisata.dart';
//
// class Kategori extends StatelessWidget {
//   final List<String> KategoriList = ['Alam', 'budaya', 'kuliner', 'keluarga'];
//   Kategori({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pilih Kategori'),
//       ),
//       body: ListView.builder(
//         itemCount: KategoriList.length,
//           itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(KategoriList[index]),
//             onTap: () {
//               Navigator.push(
//                   context,
//               MaterialPageRoute(
//                   builder: (context) => ListWisata(kategori: kategoriList[index])),
//               ),
//             };
//           ),
//           },
//       ),
//     );
//   }
// }
