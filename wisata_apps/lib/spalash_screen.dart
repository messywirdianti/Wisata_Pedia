import 'package:flutter/material.dart';
import 'package:wisata_apps/auth/Welcome.dart';
import 'package:wisata_apps/auth/login_screen.dart';
import 'package:wisata_apps/menu_tab_bar.dart';
import 'package:wisata_apps/prefs.dart';
import 'package:wisata_apps/profil_page.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {

  Future cekSession() async {
    await Future.delayed(Duration(seconds: 3), () async {
      int? val = await Prefs().getPref();
      print('vall $val');
      if (val != null) {
        setState(() {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MenuTabBar()),
      (Route<dynamic> route) => false);
        });
      } else {
        setState(() {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const WelcomePage()),
      (Route<dynamic> route) => false);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cekSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Wisata Pedia",
          style: TextStyle(
            color: Colors.indigoAccent, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
    );
  }
}
