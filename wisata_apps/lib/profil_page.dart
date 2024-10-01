import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisata_apps/auth/login_screen.dart';
import 'package:wisata_apps/prefs.dart';
import 'package:wisata_apps/response/res_user.dart';
import 'package:http/http.dart' as http;
import 'edit_user.dart';
import 'network.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool isLoading = false;
  List<DataUser>? data;
  String? idUser;
  XFile? image;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    prefs.getPref().then((_) {
      setState(() {
        idUser = prefs.idUser;
      });
      getUser();
    });
  }

  Future<void> getImage() async {
    var res = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (res != null) {
      setState(() {
        image = res;
      });
    }
  }

  Future<void> getUser() async {
    if (idUser == null || idUser!.isEmpty) {
      print('ID User is null or empty');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.post(
        Uri.parse('${baseUrl}getUser.php'),
        body: {'id': idUser},
      );

      ResUser userData = resUserFromJson(res.body);

      if (userData.isSuccess == true && userData.data != null) {
        setState(() {
          data = userData.data;
        });
      }
    } catch (e) {
      print("Error fetching user: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.indigoAccent,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout),
        //     onPressed: () {
        //       Prefs.clearSession().then((_) {
        //         Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(builder: (_) => const LoginScreen()),
        //               (Route<dynamic> route) => false,
        //         );
        //       });
        //     },
        //   )
        // ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (data == null || data!.isEmpty)
          ? const Center(child: Text('No user data available'))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: image != null
                          ? FileImage(File(image!.path))
                          : (data![0].gambarUser != null &&
                          data![0].gambarUser!.isNotEmpty)
                          ? NetworkImage(
                          '$imageUrl${data![0].gambarUser}')
                          : null,
                      child: (image == null &&
                          (data![0].gambarUser == null ||
                              data![0].gambarUser!.isEmpty))
                          ? const Icon(Icons.person,
                          size: 70, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt,
                              color: Colors.white),
                          onPressed: getImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  data![0].fullname ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const SizedBox(height: 30),
              // const Text(
              //   'Personal Information',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),
              // ListTile(
              //   leading: const Icon(Icons.email),
              //   title: const Text('Email'),
              //   subtitle: Text(data![0].email ?? ''),
              // ),
              // ListTile(
              //   leading: const Icon(Icons.phone),
              //   title: const Text('Phone'),
              //   subtitle: Text(data![0].phone ?? 'Not provided'),
              // ),
              const SizedBox(height: 20),
              const Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditUser(data![0]),
                  ).then((_) => getUser());
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: () {
                  // Implement change password functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notification Settings'),
                onTap: () {
                  // Implement notification settings
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap:() {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                  ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}