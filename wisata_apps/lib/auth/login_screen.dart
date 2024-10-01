import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_apps/auth/register_screen.dart';
import 'package:wisata_apps/menu_tab_bar.dart';
import '../network.dart';
import '../prefs.dart';
import '../response/res_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLogin = false;

  Future<ResLogin?> loginUser() async {
    if (!keyForm.currentState!.validate()) {
      // Jika form tidak valid, tidak lanjut ke loginUser
      return null;
    }

    setState(() {
      isLogin = true;
    });

    try {
      http.Response res = await http.post(
        Uri.parse('${baseUrl}login.php'),
        body: {
          'username': username.text,
          'password': password.text,
        },
      );
      ResLogin data = resLoginFromJson(res.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data.message ?? ''),
          backgroundColor: data.value == 1 ? Colors.green : Colors.red,
        ),
      );

      if (data.value == 1) {
        setState(() {
          isLogin = false;
          Prefs.savePref(data.value ?? 0, data.id ?? "");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuTabBar()),
          );
        });
      } else {
        setState(() {
          isLogin = false;
        });
      }
    } catch (e, st) {
      setState(() {
        isLogin = false;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
        log('st ${st.toString()}');
      });
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
              ),
            ),
          ),
          ),
          // Content Login
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
                        'LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 35),
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
                      const SizedBox(height: 25),
                      MaterialButton(
                        onPressed: isLogin
                            ? null // Mencegah tombol ditekan saat proses login sedang berlangsung
                            : () async {
                          await loginUser();
                        },
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: isLogin
                            ? const CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : const Text(
                          'Login',
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()));
          },
          color: Colors.white,
          textColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(width: 1, color: Colors.green)),
          child: const Text('Belum punya akun? Silahkan register'),
        ),
      ),
    );
  }
}
