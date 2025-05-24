import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/data/model/news_model.dart';
import 'package:info_a1/app/data/services/news_services.dart';
import 'package:info_a1/app/modules/profile/controllers/profile_controller.dart';
import 'package:info_a1/app/modules/savedNews/controllers/saved_news_controller.dart';
import 'package:info_a1/core/util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/add_saved_news_model.dart';

class DetailNewsController extends GetxController {
  final Data _model = Get.arguments['news_model'];
  final NewsServices _newsServices;
  late InAppWebViewController? webViewController;
  final RxDouble _progress = 0.0.obs;
  final RxString _urlWebView = "".obs;
  final String _userId = Get.find<ProfileController>().profileModel.userId;
  final RxBool _isLoading = false.obs;
  final RxBool _isSaved = false.obs;
  final Rxn<String> _errorMessage = Rxn<String>();
  final SavedNewsController _savedNewsController = Get.find();
  DetailNewsController({required NewsServices newsServices})
    : _newsServices = newsServices;

  double get progress => _progress.value;
  String get urlWebview => _urlWebView.value;
  bool get isLoading => _isLoading.value;
  bool get isSaved => _isSaved.value;

  void setProgress({required double value}) => _progress.value = value;

  void setUrl({required String url}) => _urlWebView.value = url;

  String getPathNews() {
    final WebUri webUri = WebUri(urlWebview);
    return webUri.path;
  }

  @override
  void onInit() {
    _urlWebView.value = _model.link!;
    checkSaveStatus();
    super.onInit();
  }

  // Metode untuk mengecek status simpan berita
  Future<void> checkSaveStatus() async {
    try {
      final String pathNews = getPathNews();
      if (pathNews.isEmpty) return;

      _isLoading.value = true;
      _isSaved.value = await _newsServices.isNewsSaved(_userId, pathNews);
    } catch (e) {
      _errorMessage.value = 'Failed to check save status: $e';
      // Tidak perlu menampilkan snackbar di sini karena ini method internal
    } finally {
      _isLoading.value = false;
    }
  }

  // Method untuk menyimpan berita
  Future<void> saveNews() async {
    try {
      _isLoading.value = true;

      final news = AddSavedNewsModel(
        userId: _userId,
        pathNews: getPathNews(),
        title: _model.title ?? '',
        image: _model.image,
        description: _model.description,
      );

      await _newsServices.insertSavedNews(news);
      _isSaved.value = true;

      showSnackbarSuccess('Success', 'News saved successfully');
    } catch (e) {
      _errorMessage.value = 'Failed to save news: $e';
      showSnackbarError('Error', _errorMessage.value!);
    } finally {
      _isLoading.value = false;
    }
  }

  // Method untuk menghapus berita tersimpan
  Future<void> unsaveNews() async {
    try {
      _isLoading.value = true;

      final String pathNews = getPathNews();
      if (pathNews.isEmpty) {
        _errorMessage.value = 'News path is missing';
        showSnackbarError('Error', _errorMessage.value!);
        return;
      }

      await _newsServices.deleteSavedNews(_userId, pathNews);
      _isSaved.value = false;

      showSnackbarSuccess('Success', 'News removed from saved list');
    } catch (e) {
      _errorMessage.value = 'Failed to remove saved news: $e';
      showSnackbarError('Error', _errorMessage.value!);
    } finally {
      _isLoading.value = false;
    }
  }

  // Method untuk toggle save/unsave
  Future<void> toggleSaveStatus() async {
    if (_isSaved.value) {
      await unsaveNews();
    } else {
      await saveNews();
    }
    _savedNewsController.getSavedNews();
  }

  // ensure if url not same, open with url launcher
  Future<NavigationActionPolicy> ensureUrlIsSame({required String url}) async {
    WebUri oriUrl = WebUri(_model.link!);
    WebUri newUrl = WebUri(url);

    if (oriUrl.path != newUrl.path && newUrl.host.contains("antaranews")) {
      openUrl(url);
      return NavigationActionPolicy.CANCEL;
    }
    return NavigationActionPolicy.ALLOW;
  }

  // url launcher with open url
  Future<void> openUrl(String url) async {
    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: "Konfirmasi",
      middleText:
          "Anda akan keluar dari halaman ini dan membuka dibrowser baru $url",
      textConfirm: "Ya",
      textCancel: "Tidak",
      onConfirm: () async {
        Get.back();
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      },
    );
  }
}
