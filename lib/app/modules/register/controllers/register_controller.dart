import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/data/model/profile_model.dart';
import 'package:info_a1/app/data/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/util.dart';

class RegisterController extends GetxController {
  final AuthServices authServices;

  RegisterController({required this.authServices});

  final Rx<bool> _isLoading = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isLoading => _isLoading.value;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    _isLoading.value = true;
    try {
      final AuthResponse authResponse = await authServices.register(
        email: emailController.text,
        password: passwordController.text,
      );

      if (authResponse.user != null) {
        final ProfileModel model = ProfileModel(
          userId: authResponse.user!.id,
          name: nameController.text,
          photoPath: null,
        );
        await authServices.insertProfiles(model: model);
      }

      showSnackbarSuccess("Berhasil Mendaftar", "Selamat datang");
    } on SocketException {
      showSnackbarError("Gagal", "Koneksi jaringan terputurs");
    } catch (e) {
      print(e);
      if (e is AuthException) {
        showSnackbarError("Daftar Gagal", e.message);
      } else if (e is PostgrestException) {
        showSnackbarError("Query Gagal", e.message);
      }
    }
    _isLoading.value = false;
  }
}
