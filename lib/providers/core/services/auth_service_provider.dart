import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/services/api_service.dart';
import 'package:udb_news/core/services/local_storage_service.dart';
import 'package:udb_news/core/services/auth_service.dart';
import 'package:udb_news/providers/core/services/api_service_provider.dart';
import 'package:udb_news/providers/core/services/local_storage_provider.dart';
part 'auth_service_provider.g.dart';

@riverpod
AuthService authService(Ref ref) {
  final ApiService apiService = ref.read(apiServiceProvider);
  final LocalStorageService localStorageService = ref.read(
    localStorageProvider,
  );
  return AuthService(
    apiService: apiService,
    localStorageService: localStorageService,
  );
}
