import 'package:get/get.dart';
import 'package:info_a1/app/data/model/news_model.dart';
import 'package:info_a1/app/data/services/auth_services.dart';
import 'package:info_a1/app/data/services/news_services.dart';
import 'package:info_a1/core/util.dart';

class HomeController extends GetxController {
  final AuthServices authServices;
  final NewsServices newsServices;
  final List<String> categories = [
    "politik",
    "hukum",
    "ekonomi",
    "metro",
    "sepakbola",
    "olahraga",
    "humaniora",
    "lifestyle",
    "hiburan",
    "dunia",
    "infografik",
    "tekno",
    "otomotif",
    "warta-bumi",
    "rilis-pers",
  ];

  final Rxn<NewsModel> _headlineNews = Rxn<NewsModel>();
  final Rxn<NewsModel> _listCategoryNews = Rxn<NewsModel>();
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingBottom = false.obs;
  final RxInt _categoryActive = 0.obs;

  int get getCategoryActive => _categoryActive.value;
  NewsModel? get headlineNews => _headlineNews.value;
  NewsModel? get listCategoryNews => _listCategoryNews.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingBottom => _isLoadingBottom.value;

  HomeController({required this.authServices, required this.newsServices});

  @override
  void onInit() {
    getHeadlineNews();

    ever(_categoryActive, (value) {
      getNewsWithCategory();
    });
    super.onInit();
  }

  void changeCategoryActive({required int index}) {
    _categoryActive.value = index;
  }

  void getHeadlineNews() async {
    _isLoading.value = true;
    try {
      _headlineNews.value = await newsServices.getHeadlineNews();
      await getNewsWithCategory();
    } catch (e) {
      showSnackbarError("Gagal", e.toString());
    }
    _isLoading.value = false;
  }

  Future<void> getNewsWithCategory() async {
    _isLoadingBottom.value = true;
    try {
      _listCategoryNews.value = await newsServices.getNewsWithCategory(
        category: categories[getCategoryActive],
      );
    } catch (e) {
      showSnackbarError("Gagal", e.toString());
    }
    _isLoadingBottom.value = false;
  }
}
