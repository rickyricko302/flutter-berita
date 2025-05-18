import 'package:get/get.dart';
import 'package:info_a1/app/data/services/auth_services.dart';

class HomeController extends GetxController {
  final AuthServices authServices;
  final List<String> categories = [
    "top-news",
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

  final RxInt _categoryActive = 0.obs;

  int get getCategoryActive => _categoryActive.value;

  HomeController({required this.authServices});

  void changeCategoryActive({required int index}) {
    _categoryActive.value = index;
  }

  Future<void> logout() async {
    await authServices.logout();
  }
}
