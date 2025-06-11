import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/data/model/headlines_news_model.dart';
import 'package:info_a1/app/data/services/news_services.dart';
import 'package:info_a1/app/modules/profile/controllers/profile_controller.dart';
import 'package:info_a1/app/modules/savedNews/controllers/saved_news_controller.dart';
import 'package:info_a1/core/util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/add_saved_news_model.dart';

class DetailNewsController extends GetxController {
  final Articles _model = Get.arguments['news_model'];
  final NewsServices _newsServices;
  final RxDouble _progress = 0.0.obs;
  final String _userId =
      Get.find<ProfileController>().profileModel?.userId ?? '';
  final RxBool _isLoading = false.obs;
  final RxBool _isSaved = false.obs;
  final RxBool _isShowBottomSheet = true.obs;
  final Rxn<String> _errorMessage = Rxn<String>();
  final SavedNewsController _savedNewsController = Get.find();
  DetailNewsController({required NewsServices newsServices})
    : _newsServices = newsServices;

  double get progress => _progress.value;
  bool get isLoading => _isLoading.value;
  bool get isSaved => _isSaved.value;
  bool get isShowBottomSheet => _isShowBottomSheet.value;
  Articles get newsModel => _model;

  @override
  void onInit() {
    checkSaveStatus();
    super.onInit();
  }

  // Metode untuk mengecek status simpan berita
  Future<void> checkSaveStatus() async {
    try {
      _isLoading.value = true;
      _isSaved.value = await _newsServices.isNewsSaved(
        _userId,
        _model.title ?? '-',
      );
    } catch (e) {
      _errorMessage.value = 'Failed to check save status: $e';
      // Tidak perlu menampilkan snackbar di sini karena ini method internal
    } finally {
      _isLoading.value = false;
    }
  }

  // // Method untuk menyimpan berita
  Future<void> saveNews() async {
    try {
      _isLoading.value = true;

      await _newsServices.insertSavedNews(_userId, _model);
      _isSaved.value = true;

      showSnackbarSuccess('Success', 'News saved successfully');
    } catch (e) {
      _errorMessage.value = 'Failed to save news: $e';
      showSnackbarError('Error', _errorMessage.value!);
    } finally {
      _isLoading.value = false;
    }
  }

  // // Method untuk menghapus berita tersimpan
  Future<void> unsaveNews() async {
    try {
      _isLoading.value = true;

      await _newsServices.deleteSavedNews(_userId, _model.title ?? '-');
      _isSaved.value = false;

      showSnackbarSuccess('Success', 'News removed from saved list');
    } catch (e) {
      _errorMessage.value = 'Failed to remove saved news: $e';
      showSnackbarError('Error', _errorMessage.value!);
    } finally {
      _isLoading.value = false;
    }
  }

  // // Method untuk toggle save/unsave
  Future<void> toggleSaveStatus() async {
    if (_isSaved.value) {
      await unsaveNews();
    } else {
      await saveNews();
    }
    _savedNewsController.getSavedNews();
  }

  // url launcher with open url
  Future<void> openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> setIsShowBottomSheet({required bool value}) async {
    if (value == _isShowBottomSheet.value) return;
    _isShowBottomSheet.value = value;
  }
}
