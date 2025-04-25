import 'package:udb_news/core/models/profile_model.dart';
import 'package:udb_news/core/models/user_model.dart';
import 'package:udb_news/core/services/auth_service.dart';

abstract class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
    required bool isRememberMe,
  });
  Future<ProfileModel> getProfile();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
    : _authService = authService;
  @override
  Future<UserModel> login({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    return _authService.login(
      email: email,
      password: password,
      isRememberMe: isRememberMe,
    );
  }

  @override
  Future<ProfileModel> getProfile() async {
    return ProfileModel();
  }
}
