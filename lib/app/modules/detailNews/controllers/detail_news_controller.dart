import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/data/model/news_model.dart';
import 'package:info_a1/app/data/services/remote_database_service.dart';
import 'package:info_a1/app/modules/profile/controllers/profile_controller.dart';
import 'package:info_a1/core/util.dart';

import '../../../data/model/add_saved_news_model.dart';

class DetailNewsController extends GetxController {
  final Data _model = Get.arguments['news_model'];
  final RemoteDatabaseService _remoteDb;
  late InAppWebViewController? webViewController;
  final RxDouble _progress = 0.0.obs;
  final RxString _url = "".obs;
  final String _userId = Get.find<ProfileController>().profileModel.userId;
  final RxBool _isLoading = false.obs;
  final RxBool _isSaved = false.obs;
  final Rxn<String> _errorMessage = Rxn<String>();
  DetailNewsController({required RemoteDatabaseService remoteDb})
    : _remoteDb = remoteDb;

  double get progress => _progress.value;
  String get urlWebview => _url.value;
  bool get isLoading => _isLoading.value;
  bool get isSaved => _isSaved.value;

  void setProgress({required double value}) => _progress.value = value;

  void setUrl({required String url}) => _url.value = url;

  String getPathNews() {
    final WebUri webUri = WebUri(urlWebview);
    return webUri.path;
  }

  @override
  void onInit() {
    _url.value = _model.link!;
    checkSaveStatus();
    super.onInit();
  }

  // Metode untuk mengecek status simpan berita
  Future<void> checkSaveStatus() async {
    try {
      final String pathNews = getPathNews();
      if (pathNews.isEmpty) return;

      _isLoading.value = true;
      _isSaved.value = await _remoteDb.isNewsSaved(_userId, pathNews);
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

      await _remoteDb.insertSavedNews(news);
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

      await _remoteDb.deleteSavedNews(_userId, pathNews);
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
  }
}
