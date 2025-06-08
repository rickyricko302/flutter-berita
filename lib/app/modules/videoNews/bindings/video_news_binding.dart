import 'package:get/get.dart';

import '../controllers/video_news_controller.dart';

class VideoNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoNewsController>(
      () => VideoNewsController(),
    );
  }
}
