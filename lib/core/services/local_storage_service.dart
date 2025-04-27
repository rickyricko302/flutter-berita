import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  final FlutterSecureStorage _flutterSecureStorage;

  LocalStorageService({required FlutterSecureStorage flutterSecureStorage})
    : _flutterSecureStorage = flutterSecureStorage;
  Future<void> write({required String key, required String value}) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  Future<dynamic> read({key}) async {
    return await _flutterSecureStorage.read(key: key);
  }
}
