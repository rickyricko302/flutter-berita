import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/modules/home/controllers/home_controller.dart';
import 'package:info_a1/app/modules/profile/controllers/profile_controller.dart';

class DashboardController extends GetxController {
  final PageController pageController = PageController();
  final _indexActive = 0.obs;

  get getIndexActive => _indexActive.value;

  void changeIndexActive({required int index}) {
    _indexActive.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    Get.put(HomeController(authServices: Get.find(), newsServices: Get.find()));
    Get.put(
      ProfileController(authServices: Get.find(), profileServices: Get.find()),
    );
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
