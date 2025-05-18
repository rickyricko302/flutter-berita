import 'package:get/get.dart';
import 'package:info_a1/app/data/services/auth_services.dart';

class HomeController extends GetxController {
  final AuthServices authServices;

  HomeController({required this.authServices});

  Future<void> logout() async {
    await authServices.logout();
  }
}
