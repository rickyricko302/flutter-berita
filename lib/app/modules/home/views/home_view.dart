import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:info_a1/app/modules/home/views/widgets/categories.dart';
import 'package:info_a1/app/modules/home/views/widgets/headline.dart';
import 'package:info_a1/app/modules/home/views/widgets/list_news.dart';

import '../../../../core/util.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda', style: TextStyle(color: Colors.white)),
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
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child:
              controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadLineWidget(headlineNews: controller.headlineNews),
                          CategoriesWidget(controller: controller),
                          ListNews(
                            isLoading: controller.isLoadingBottom,
                            listNews: controller.listCategoryNews,
                          ),
                        ],
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
