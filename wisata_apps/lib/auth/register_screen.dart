import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../network.dart';
import 'package:http/http.dart' as http;
import '../response/res_register.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  XFile? image;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  Future<void> getImage() async {
    var res = await ImagePicker().pickImage(source: ImageSource.camera);
    if (res != null){
      setState(() {
        image = res;
      });
    }
  }

  bool isRegister = false;

  // Fungsi untuk validasi email
  String? validateEmail(String? value) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!regExp.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  Future<ResRegister?> registerUser() async {
    if (!keyForm.currentState!.validate()) {
      // Jika form tidak valid, tidak lanjut ke registerUser
      return null;
    }

    // void showPicker(BuildContext context) {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (BuildContext bc) {
    //         return SafeArea(
    //             child: Wrap(
    //               children: <Widget>[
    //                 ListTile(
    //                   leading: const Icon(Icons.photo_library),
    //                   title: const Text('Galerry'),
    //                   onTap: () {
    //                     getImage(ImageSource.gallery);
    //                     Navigator.of(context).pop();
    //                   },
    //                 ),
    //                 ListTile(
    //                   leading: const Icon(Icons.photo_camera),
    //                   title: const Text('kamera'),
    //                   onTap: () {
    //                     getImage(ImageSource.camera);
    //                     Navigator.of(context).pop();
    //                   },
    //                 )
    //               ],
    //             ));
    //       });
    // }



    try {
      setState(() {
        isRegister = true;
      });
      var request =
      http.MultipartRequest('POST', Uri.parse('${baseUrl}register.php'))
      ..fields['username'] = username.text
      ..fields['nama_lengkap'] = fullname.text
      ..fields['password'] =  password.text
      ..files.add(await http.MultipartFile.fromPath('gambar', image!.path));
      http.StreamedResponse data = await request.send();
      String resString = await data.stream.bytesToString();
      ResRegister res = resRegisterFromJson(resString);
      if (res.value == 1) {
        setState(() {
          isRegister = false;
        });
        // Berhasil registrasi, pindah ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        setState(() {
          isRegister = false;
        });
      }
    } catch (e, st) {
      setState(() {
        isRegister = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      log('st ${st.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Opacity(
        opacity: 0.5,
        // Background Image
        child:  Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/travelling.jpg'),
                fit: BoxFit.cover,
              )
            ),
          ),
        ),
    Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Form(
                key: keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'REGISTER',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 35),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Fullname tidak boleh kosong" : null;
                      },
                      controller: fullname,
                      decoration: InputDecoration(
                          hintText: 'fullname',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Username tidak boleh kosong" : null;
                      },
                      controller: username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Password tidak boleh kosong" : null;
                      },
                      obscureText: true,
                      controller: password,
                      decoration: InputDecoration(
                          hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    image != null
                    ? Center (
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.file(File(image!.path))),
                    )
                    : Center(
                      child: MaterialButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5,),
                          side: const BorderSide(
                            width: 2, color: Colors.indigoAccent)),
                        onPressed: () async {
                          await getImage();
                        },
                            child: const Text(
                            'Upload Gambar',
                              style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ),
                    ),
                    const SizedBox(height: 25),
                    MaterialButton(
                      onPressed: isRegister
                          ? null // Mencegah tombol ditekan saat proses register sedang berlangsung
                          : () async {
                        await registerUser();
                      },
                      textColor: Colors.white,
                      color: Colors.indigoAccent,
                      child: isRegister
                          ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : const Text(
                        'Register',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
              ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          color: Colors.white,
          textColor: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(width: 1, color: Colors.indigoAccent)),
          child: const Text('anda sudah punya akan! silahkan login'),
        ),
      ),
    );
  }
}
