import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/models/user_model.dart';
import 'package:udb_news/core/repositories/auth_repository.dart';
import 'package:udb_news/providers/core/repositories/auth_repository_provider.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<UserModel?> build() => null;

  Future<void> login({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    state = AsyncLoading();
    try {
      final AuthRepositoryImpl authRepositoryImpl = ref.read(
        authRepositoryProvider,
      );
      final UserModel data = await authRepositoryImpl.login(
        email: email,
        password: password,
        isRememberMe: isRememberMe,
      );
      state = AsyncData(data);
    } catch (e) {
      debugPrint(e.toString());
      state = AsyncError(e, StackTrace.current);
    }
  }
}
