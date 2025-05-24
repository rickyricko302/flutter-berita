import 'package:get/get.dart';

import '../controllers/saved_news_controller.dart';

class SavedNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedNewsController>(
      () => SavedNewsController(
        newsServices: Get.find(),
        authServices: Get.find(),
      ),
    );
  }
}
