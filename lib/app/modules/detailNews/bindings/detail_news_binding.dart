import 'package:get/get.dart';

import '../controllers/detail_news_controller.dart';

class DetailNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNewsController>(
      () => DetailNewsController(),
    );
  }
}
