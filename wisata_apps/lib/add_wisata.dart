import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisata_apps/response/res_get_kategori.dart';
import 'package:wisata_apps/response/res_get_wisata.dart';
import 'package:wisata_apps/response/res_register.dart';
import 'package:http/http.dart' as http;

import 'network.dart';

class AddWisata extends StatefulWidget {
  const AddWisata({super.key});

  @override
  State<AddWisata> createState() => _AddWisataState();
}

class _AddWisataState extends State<AddWisata> {
  TextEditingController namaWisata = TextEditingController();
  TextEditingController kategori = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  XFile? image;
  String? pilihKategori;
  List<DataKategori> listKategori = [];
  bool isAddWisata = false, isKategori = false;

  Future<ResGetKategori?> getKategori() async {
    try {
      setState(() {
        isKategori = true;
      });
      http.Response res = await http.get(Uri.parse('${baseUrl}getKategori.php'));
      log('Response from get_kategori:${res.body}');
      if (res.body.isEmpty) {
        throw Exception("Response is empty");
      }
      List<DataKategori>? data = resGetKategoriFromJson(res.body).data;
      setState(() {
        isKategori= false;
        listKategori = data ?? [];
      });
    } catch (e, st) {
      setState(() {
        isKategori = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${e.toString()}'),
        backgroundColor: Colors.red,
      ));
      log('Stack trace: ${st.toString()}');
    }
  }

  Future<void> getImage() async {
    var res = await ImagePicker().pickImage(source: ImageSource.camera);
    if (res != null) {
      setState(() {
        image = res;
      });
    }
  }



  Future<ResRegister?> addWisata() async {
    if (namaWisata.text.isEmpty || pilihKategori == null || lokasi.text.isEmpty || latitude.text.isEmpty || longitude.text.isEmpty || image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Semua field harus diisi!'),
        backgroundColor: Colors.red,
      ));
      return null;
    }
    try{
      setState(() {
        isAddWisata = true;
      });
      var request =
      http.MultipartRequest('POST', Uri.parse('${baseUrl}add_wisata.php'))
        ..fields['nama_wisata'] = namaWisata!.text
        ..fields['kategori'] = pilihKategori!
        ..fields['lokasi'] = lokasi!.text
        ..fields['latitude'] = latitude!.text
        ..fields['longitude'] = longitude!.text
        ..files.add(await http.MultipartFile.fromPath('gambar', image!.path));
      http.StreamedResponse data = await request.send();
      String resString = await data.stream.bytesToString();
      ResRegister res = resRegisterFromJson(resString);
      if (res.value == 1) {
        setState(() {
          isAddWisata = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res.message ?? ''), backgroundColor: Colors.indigoAccent,));
        });
      } else {
        setState(() {
          isAddWisata = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res.message ?? ''), backgroundColor: Colors.indigoAccent,));
        });
      }
    }
    catch(e, st) {
      setState(() {
        isAddWisata = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()), backgroundColor: Colors.indigoAccent,));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKategori();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wisata'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image != null
                  ? Center(
                child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.file(File(image!.path))),
              )
                  : Center(
                child: MaterialButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      side: const BorderSide(
                          width: 2, color: Colors.indigoAccent)),
                  onPressed: () async {
                    await getImage();
                  },
                  child: const Text(
                    'Ambil Gambar',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: namaWisata,
                decoration: const InputDecoration(
                  hintText: 'Nama Wisata',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text('Pilih Kategori'),
                value: pilihKategori,
                  items: listKategori.isEmpty
                  ? []
                : listKategori.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.kategori,
                    child: Text(e.kategori ?? ''),
                  );
                  }).toList(),
                onChanged: (val) {
                  setState(() {
                    pilihKategori = val as String?;
                  });
                },
              ),
              TextFormField(
                controller: lokasi,
                decoration: const InputDecoration(
                  hintText: 'Lokasi',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: latitude,
                decoration: const InputDecoration(
                  hintText: 'latitude',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: longitude,
                decoration: const InputDecoration(
                  hintText: 'longitude',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: isAddWisata ? const CircularProgressIndicator(
                  color: Colors.indigoAccent,
                ) :MaterialButton(
                  color: Colors.indigoAccent,
                  minWidth: 150,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  onPressed: () {
                    addWisata();
                  },
                  child: Text('Simpan'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
