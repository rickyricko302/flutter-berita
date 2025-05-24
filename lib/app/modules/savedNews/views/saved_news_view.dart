import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:info_a1/app/modules/savedNews/views/widgets/list_saved_news.dart';

import '../../../../core/util.dart';
import '../controllers/saved_news_controller.dart';

class SavedNewsView extends GetView<SavedNewsController> {
  const SavedNewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Tersimpan', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor(context: context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Obx(
        () =>
            controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListSavedNews(savedNews: controller.savedNews),
      ),
    );
  }
}
