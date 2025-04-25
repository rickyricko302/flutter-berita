import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/repositories/auth_repository.dart';
import 'package:udb_news/core/services/auth_service.dart';
import 'package:udb_news/providers/core/services/auth_service_provider.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepositoryImpl authRepository(Ref ref) {
  final AuthService authService = ref.read(authServiceProvider);
  return AuthRepositoryImpl(authService: authService);
}
