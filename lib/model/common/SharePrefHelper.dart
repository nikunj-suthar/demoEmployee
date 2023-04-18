


import 'package:shared_preferences/shared_preferences.dart';

SetIntoDefault(String? key,String? values) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key!, values!);
}

Future<String?> GetFromDefault(String? key) async {
  var value = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString(key!) != null) {
    value = prefs.getString(key)!;
  }
  return value;
}

RemoveFromDefault() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("ISLOGIN");
}