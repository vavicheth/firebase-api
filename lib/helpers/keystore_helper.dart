import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final storage = new FlutterSecureStorage();

writeStorage(String key, String value) async {
  await storage.write(key: key, value: value);
}

Future<String> readStorage(String key) async {
  String value = await storage.read(key: key);
  print('sotrage value: $value');
  return value;
}
