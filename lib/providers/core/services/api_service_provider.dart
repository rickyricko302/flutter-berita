import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/services/api_service.dart';
import 'package:udb_news/core/services/local_storage_service.dart';
import 'package:udb_news/providers/core/services/local_storage_provider.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  final LocalStorageService localStorageService = ref.read(
    localStorageProvider,
  );
  return ApiService(localStorageService: localStorageService);
}
