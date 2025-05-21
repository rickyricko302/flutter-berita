import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class DetailNewsController extends GetxController {
  final String initUrl = Get.parameters['url_berita']!;
  InAppWebViewController? webViewController;
  final RxDouble _progress = 0.0.obs;
  final RxString _url = "".obs;

  DetailNewsController();

  double get progress => _progress.value;
  String get urlWebview => _url.value;

  void setProgress({required double value}) => _progress.value = value;

  void setUrl({required String url}) => _url.value = url;

  void logicBookmark() {
    final WebUri webUri = WebUri(urlWebview);
    print(webUri.path);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _url.value = initUrl;
    super.onInit();
  }
}
