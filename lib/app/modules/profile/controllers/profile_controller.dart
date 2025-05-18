import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/data/model/profile_model.dart';
import 'package:info_a1/app/data/model/update_profile_model.dart';
import 'package:info_a1/app/data/services/auth_services.dart';
import 'package:info_a1/app/data/services/profile_services.dart';
import 'package:info_a1/core/util.dart';

class ProfileController extends GetxController {
  final AuthServices authServices;
  final ProfileServices profileServices;
  final Rxn<ProfileModel> _profileModel = Rxn<ProfileModel>();
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingUpdate = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool get isLoading => _isLoading.value;
  bool get isLoadingUpdate => _isLoadingUpdate.value;
  ProfileModel get profileModel => _profileModel.value!;

  ProfileController({
    required this.authServices,
    required this.profileServices,
  });

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    _isLoading.value = true;
    try {
      _profileModel.value = await authServices.getProfile(
        userId: authServices.uid!,
      );
      nameController.value = TextEditingValue(text: profileModel.name);
      phoneController.value = TextEditingValue(text: profileModel.phone ?? "-");
      addressController.value = TextEditingValue(
        text: profileModel.address ?? "-",
      );
    } on SocketException {
      showSnackbarError("Gagal", "Jaringan internet Anda terputus");
    } catch (e) {
      showSnackbarError("Gagal", e.toString());
    }
    _isLoading.value = false;
  }

  Future<void> updateProfile() async {
    _isLoadingUpdate.value = true;
    try {
      UpdateProfileModel updateProfileModel = UpdateProfileModel(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
      );
      await profileServices.updateProfile(profileModel: updateProfileModel);
      showSnackbarSuccess("Berhasil", "Update profil.");
    } catch (e) {
      showSnackbarError("Gagal", e.toString());
    }
    _isLoadingUpdate.value = false;
  }

  Future<void> logout() async {
    _isLoading.value = true;
    await authServices.logout();
    showSnackbarSuccess("Berhasil", "Logout.");
    _isLoading.value = false;
  }
}
