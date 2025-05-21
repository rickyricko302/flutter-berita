import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/core/util.dart';

import '../controllers/detail_news_controller.dart';

class DetailNewsView extends GetView<DetailNewsController> {
  const DetailNewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WebView Antara News",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor(context: context),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            // Progress Bar
            controller.progress < 1.0
                ? LinearProgressIndicator(value: controller.progress)
                : Container(),

            // WebView
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri.uri(Uri.parse(controller.initUrl)),
                ),
                initialSettings: InAppWebViewSettings(),
                onWebViewCreated: (controllerWebview) {
                  controller.webViewController = controllerWebview;
                },
                onLoadStart: (controllerWebview, url) {
                  controller.setUrl(url: url.toString());
                },
                onLoadStop: (controllerWebview, url) {
                  controller.setUrl(url: url.toString());
                },
                onProgressChanged: (controllerWebview, progress) {
                  controller.setProgress(value: progress / 100);
                },

                shouldOverrideUrlLoading: (
                  controllerWebview,
                  navigationAction,
                ) async {
                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),
          ],
        ),
      ),
      // Tombol navigasi
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft02,
                color: primaryColor(context: context),
              ),
              onPressed: () {
                controller.webViewController?.goBack();
              },
            ),
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight02,
                color: primaryColor(context: context),
              ),
              onPressed: () {
                controller.webViewController?.goForward();
              },
            ),
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedBookmarkAdd01,
                color: primaryColor(context: context),
              ),
              onPressed: () {
                controller.logicBookmark();
              },
            ),
          ],
        ),
      ),
    );
  }
}
