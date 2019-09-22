import 'package:shared_preferences/shared_preferences.dart';

readDataFromLocal(String mykey) async {
  final prefs = await SharedPreferences.getInstance();
  final key = mykey;
  final value = prefs.getString(key) ?? '';
  print('read: $value');
  return value;
}

saveDataToLocal(String mykey, String myval) async {
  final prefs = await SharedPreferences.getInstance();
  final key = mykey;
  final value = myval;
  prefs.setString(key, value);
  print('saved $value');
}
