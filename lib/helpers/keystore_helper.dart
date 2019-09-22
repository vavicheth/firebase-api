import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final storage = new FlutterSecureStorage();

Future writeStorage(String key, String value) async {
  await storage.write(key: key, value: value);
}

Future<void> readStorage(String key) async {
  String value = await storage.read(key: key);
  print('sotrage value: $value');
  return value;
}
