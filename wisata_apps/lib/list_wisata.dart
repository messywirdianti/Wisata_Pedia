import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_apps/add_wisata.dart';
import 'package:wisata_apps/response/res_get_wisata.dart';
import 'package:wisata_apps/response/res_register.dart';

import 'detail_wisata.dart';
import 'network.dart';

class ListWisata extends StatefulWidget {
 final String nama_wisata;
 final String kategori;
 final String gambar;
 final String lokasi;
 const ListWisata({required this.nama_wisata, required this.kategori, required this.gambar, required this.lokasi,super.key});

  @override
  State<ListWisata> createState() => _ListWisataState();
}

class _ListWisataState extends State<ListWisata> {
  List<DataWisata> listWisata = [];
  List<DataWisata> filterList = [];
  TextEditingController cariTempatLiburan = TextEditingController();
  bool isWisata = false, isDelete = false;
  Set<int> favoriteWisataIds = {};

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
        filterList = listWisata;
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

  Future<ResRegister?> deleteBerita(String id) async {
    try {
      setState(() {
        isDelete = true;
      });
      http.Response res = await http.post(
          Uri.parse('${baseUrl}delete_berita.php'),
          body: {'idBerita': id});
      ResRegister data = resRegisterFromJson(res.body);
      if (data.value == 1) {
        setState(() {
          isDelete = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data.message ?? ""),
            backgroundColor: Colors.indigoAccent,
          ));
        });
      } else {
        setState(() {
          isDelete = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data.message ?? ""),
          ));
        });
      }
    } catch (e, st) {
      setState(() {
        isDelete = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.indigoAccent,
        ));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWisata();
    cariTempatLiburan.addListener(() {
      performSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Wisata'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddWisata()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: cariTempatLiburan,
              decoration: const InputDecoration(
                  hintText: 'Cari Tempat Liburan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          isWisata
          ? const Center(
            child: CircularProgressIndicator(
              color: Colors.indigoAccent,
            ),
          )
              : Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: filterList.length,
              itemBuilder: (context, index) {
                DataWisata data = filterList[index];
                final isFavorite = favoriteWisataIds.contains(data.id);
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 5,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailWisata(wisata: data),
                          ),
                        );
                      },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Image.network(
                            '$imageUrl${data.gambarWisata}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.namaWisata ?? 'Nama Wisata',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data.lokasi ?? 'Lokasi Wisata',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data.kategori ?? 'Kategori',
                                  style: const TextStyle(
                                    color: Colors.indigoAccent,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                            onPressed: () {
                              setState(() {
                                if (data.id != null) {
                                  int id = int.parse(data.id!);
                                  if (id != null) {
                                if (isFavorite) {
                                  favoriteWisataIds.remove(data.id);
                                } else {
                                  favoriteWisataIds.add(id);
                                }
                              } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('ID tidak valid')),
                                    );
                                  }
                                  }
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void performSearch() {
    String query = cariTempatLiburan.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filterList = listWisata;
      } else {
        filterList = listWisata
            .where((wisata) =>
        wisata.namaWisata!.toLowerCase().contains(query) ?? false)
            .toList();
      }
    });
  }
}