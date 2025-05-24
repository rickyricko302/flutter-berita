import 'package:get/get.dart';
import 'package:info_a1/app/data/services/auth_services.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final AuthServices authServices;
  SplashScreenController({required this.authServices});

  final RxBool _isAnimated = false.obs;

  bool get isAnimated => _isAnimated.value;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(seconds: 1), () {
      _isAnimated.value = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      authServices.listenAuth(
        goHome: () => Get.offAllNamed(Routes.DASHBOARD),
        goLogin: () => Get.offAllNamed(Routes.LOGIN),
      );
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
