import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/data/model/profile_model.dart';
import 'package:info_a1/app/data/services/auth_services.dart';
import 'package:info_a1/core/util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final AuthServices authServices;
  LoginController({required this.authServices});

  final Rx<bool> _isLoading = false.obs;
  final Rx<bool> _isGoogleLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isLoading => _isLoading.value;
  bool get isGoogleLoading => _isGoogleLoading.value;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> doLogin() async {
    _isLoading.value = true;
    try {
      await authServices.login(
        email: emailController.text,
        password: passwordController.text,
      );
    } on SocketException {
      showSnackbarError("Gagal", "Koneksi jaringan terputurs");
    } catch (e) {
      if (e is AuthApiException) {
        showSnackbarError("Login Gagal", e.message);
      }
    }
    _isLoading.value = false;
  }

  Future<void> doGoogleLogin() async {
    _isGoogleLoading.value = true;
    try {
      final AuthResponse authResponse = await authServices.googleSignIn();
      if (authResponse.user != null) {
        String userId = authResponse.user?.id ?? '-';
        bool hasProfile =
            (await authServices.getProfile(userId: userId)) != null;
        if (!hasProfile) {
          final Map<String, dynamic>? userMetaData =
              authResponse.user!.userMetadata;
          final ProfileModel model = ProfileModel(
            userId: userId,
            name: userMetaData?['full_name'] ?? '-',
            photoPath: userMetaData?['avatar_url'] ?? '-',
          );
          await authServices.insertProfiles(model: model);
        }
      }
      log(authResponse.toString());
    } catch (e) {
      showSnackbarError("Error", e.toString());
    }
    _isGoogleLoading.value = false;
  }
}
