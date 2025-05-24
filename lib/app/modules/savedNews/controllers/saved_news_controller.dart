import 'package:get/get.dart';
import 'package:info_a1/app/data/model/saved_news_model.dart';
import 'package:info_a1/app/data/services/auth_services.dart';
import 'package:info_a1/app/data/services/news_services.dart';
import 'package:info_a1/core/util.dart';

class SavedNewsController extends GetxController {
  final NewsServices _newsServices;
  final AuthServices _authServices;
  final RxBool _isLoading = false.obs;
  final Rx<List<SavedNewsModel>> _savedNews = Rx<List<SavedNewsModel>>([]);

  bool get isLoading => _isLoading.value;
  List<SavedNewsModel> get savedNews => _savedNews.value;

  SavedNewsController({
    required NewsServices newsServices,
    required AuthServices authServices,
  }) : _newsServices = newsServices,
       _authServices = authServices;

  @override
  void onInit() {
    super.onInit();
    getSavedNews();
  }

  Future<void> getSavedNews() async {
    try {
      _isLoading.value = true;
      _savedNews.value = await _newsServices.getSavedNewsByUserId(
        _authServices.uid!,
      );
      _isLoading.value = false;
    } catch (e) {
      showSnackbarError("Gagal", e.toString());
    }
  }
}
