import 'package:get/get.dart';
import 'package:info_a1/app/data/services/auth_services.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final AuthServices authServices;

  SplashScreenController({required this.authServices});

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(seconds: 1), () {
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
