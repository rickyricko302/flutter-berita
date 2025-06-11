import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gap/gap.dart';

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
        centerTitle: true,
        title: Text("Detail Berita", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(controller.newsModel.urlToImage ?? ''),
              ),
              Gap(8),
              Text(
                controller.newsModel.title ?? '',
                style: titleLarge(context: context),
              ),
              Gap(8),
              Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedUserGroup03,
                    color: primaryColor(context: context),
                  ),
                  Gap(8),
                  Text(
                    'Author: ${controller.newsModel.author ?? ''}',
                    style: labelLarge(context: context),
                  ),
                ],
              ),
              Gap(8),
              Gap(8),
              Text(
                controller.newsModel.description ?? '',
                style: bodyNormal(context: context),
              ),
              Gap(8),
              Text(
                controller.newsModel.content ?? '',
                style: bodyNormal(context: context),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    controller.openUrl(controller.newsModel.url ?? '');
                  },
                  child: Text('Lihat berita selengkapnya disini'),
                ),
              ),
            ],
          ),
        ),
      ),
      // Tombol navigasi
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          height: 60,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controller.isLoading
                    ? CircularProgressIndicator()
                    : IconButton(
                      icon: HugeIcon(
                        icon:
                            controller.isSaved
                                ? HugeIcons.strokeRoundedBookmarkRemove01
                                : HugeIcons.strokeRoundedBookmarkAdd01,
                        color: primaryColor(context: context),
                      ),
                      onPressed: () {
                        controller.toggleSaveStatus();
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
