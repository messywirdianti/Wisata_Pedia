import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  int? value;
  String? idUser;

  static Future<void> savePref(int val, String myId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('value', val);
    prefs.setString('id', myId);
  }

  Future<int?> getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('value');
    idUser = prefs.getString('id');
    return value;
  }

  static Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

Prefs prefs = Prefs();