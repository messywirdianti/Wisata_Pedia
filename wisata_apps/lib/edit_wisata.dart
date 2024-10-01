import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisata_apps/menu_tab_bar.dart';
import 'package:wisata_apps/response/res_get_wisata.dart';
import 'package:wisata_apps/response/res_register.dart';
import 'package:wisata_apps/response/res_update_user.dart';
import 'package:http/http.dart' as http;
import 'network.dart';

class EditWisata extends StatefulWidget {
  final DataWisata? data;
  const EditWisata(this.data, {super.key});

  @override
  State<EditWisata> createState() => _EditWisataState();
}

class _EditWisataState extends State<EditWisata> {
  TextEditingController? namaWisata, lokasi, kategori;
  XFile? image;



  Future<void> getImage() async {
    var res = await ImagePicker().pickImage(source: ImageSource.camera);
    if (res != null) {
      setState(() {
        image = res;
      });
    }
  }

  bool isUpdateWisata = false;

  Future<ResRegister?> updateWisata() async {
    try {
      setState(() {
        isUpdateWisata = true;
      });

      print('Nama Wisata: ${namaWisata!.text}');
      print('Kategori: ${kategori!.text}');
      print('Lokasi: ${lokasi!.text}');
      print('Gambar Path: ${image?.path ?? widget.data?.gambarWisata}');

      var request =
      http.MultipartRequest('POST',
          Uri.parse('${baseUrl}update_wisata.php'))
        ..fields['id'] = widget.data!.id.toString()
        ..fields['nama_wisata'] = namaWisata!.text
        ..fields['kategori'] = kategori!.text
        ..fields['lokasi'] = lokasi!.text;

      if (image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('gambar_wisata', image!.path));
      }
      http.StreamedResponse data = await request.send();
      String resString = await data.stream.bytesToString();
      print("Response: $resString");

      ResUpdateUser res = resUpdateUserFromJson(resString);
      if (res.value == 1) {
        setState(() {
          isUpdateWisata = false;
        });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MenuTabBar()),
                (Route<dynamic> route) => false,
          );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res.message ?? ""),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e, st) {
      print('sttt ${st.toString()}');
      print('eeeee ${e.toString()}');
      setState(() {
        isUpdateWisata = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.indigoAccent,
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namaWisata = TextEditingController(text: widget.data?.namaWisata);
    kategori = TextEditingController(text: widget.data?.kategori);
    lokasi = TextEditingController(text: widget.data?.lokasi);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Wisata'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              image != null
              ? Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.file(File(image!.path))),
                )
                  : Center(
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 2, color: Colors.indigoAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                  onPressed: () async {
                  await getImage();
                  },
                  child: Image.network('$imageUrl${widget.data?.gambarWisata}'),
              ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: namaWisata,
                decoration: const InputDecoration(hintText: 'Nama Wisata'),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: kategori,
                decoration: const InputDecoration(hintText: 'Kategori'),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: lokasi,
                decoration: const InputDecoration(hintText: 'lokasi'),
              ),
              const SizedBox(height: 18),
              isUpdateWisata
                  ? const CircularProgressIndicator(
                color: Colors.indigoAccent,
              )
                  : Center(
                child: MaterialButton(
                  color: Colors.indigoAccent,
                  minWidth: 150,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  onPressed: () async {
                    await updateWisata();
                  },
                  child: const Text('UPDATE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

