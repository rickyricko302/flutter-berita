import 'package:get_storage/get_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/services/local_storage_service.dart';
part 'local_storage_provider.g.dart';

@riverpod
class LocalStorage extends _$LocalStorage {
  @override
  LocalStorageService build() => LocalStorageService(box: GetStorage());
}
