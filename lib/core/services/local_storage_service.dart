import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final GetStorage _box;

  LocalStorageService({required GetStorage box}) : _box = box;
  Future<void> write({required String key, required String value}) async {
    await _box.write(key, value);
  }

  Future<dynamic> read({key}) async {
    return await _box.read(key);
  }

  Future<void> remove({key}) async {
    return await _box.remove(key);
  }
}
