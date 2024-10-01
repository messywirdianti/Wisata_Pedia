import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wisata_apps/prefs.dart';
import 'package:wisata_apps/response/res_update_user.dart';
import 'package:wisata_apps/response/res_user.dart';

import 'network.dart';


class EditUser extends StatefulWidget {
  final DataUser e;
  const EditUser(this.e, {super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController? fullname;
  TextEditingController? username;
  String? idUser;
  XFile? image;

  Future<void> getImage() async {
    var res =  await ImagePicker().pickImage(source: ImageSource.camera);
    if (res != null) {
      setState(() {
        image =  res;
      });
    }
  }

  bool isUpdate = false;
  Future<ResUpdateUser?> updateUser() async {
    try {
      setState(() {
        isUpdate = true;
      });
      var request =
      http.MultipartRequest('POST',
          Uri.parse('${baseUrl}updateUser.php'))
          ..fields['id'] = idUser ?? ''
          ..fields['fullname'] = fullname!.text ?? ''
          ..fields['username'] = username!.text ?? '';
      if (image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('gambar_user', image!.path));
      }
      http.StreamedResponse data = await request.send();
      String resString = await data.stream.bytesToString();
      print("Response String: $resString");
      ResUpdateUser res = resUpdateUserFromJson(resString);
      if (res.value == 1) {
        setState(() {
          isUpdate = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(res.message ?? ''), backgroundColor: Colors.indigoAccent,));
        });
      } else {
        setState(() {
          isUpdate = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(res.message ?? ''), backgroundColor: Colors.indigoAccent,));
        });
      }
    }
    catch(e, st) {
      print("Error: $e");
      setState(() {
        isUpdate = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()), backgroundColor: Colors.indigoAccent,));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefs.getPref().then((_) {
      setState(() {
        idUser = prefs.idUser;
        print('id_user $idUser');
      });
    });
    fullname = TextEditingController(text: widget.e.fullname);
    username = TextEditingController(text: widget.e.username);

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Center(child: Text('Edit User')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
                borderRadius: BorderRadius.circular(10,),

              side: const BorderSide(
                width: 2, color: Colors.indigoAccent)),
              onPressed: () async {
                await  getImage();
              },
              child: const Text(
                'Ambal Gambar',
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: fullname,
            decoration: const InputDecoration(hintText: 'Fullname'),
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: username,
            decoration: const InputDecoration(hintText: 'Username'),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: isUpdate ? const CircularProgressIndicator(
              color: Colors.indigoAccent,
            ) : MaterialButton(
              color: Colors.green,
                minWidth: 150,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
                textColor: Colors.white,
                onPressed: () {
                updateUser();
                },
              child: Text('Simpan'),
            )
          )

        ],
      ),
    );
  }
}
