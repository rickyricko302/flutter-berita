import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/app/data/model/saved_news_model.dart';

import '../../../../../core/util.dart';
import '../../../../data/model/news_model.dart';
import '../../../../routes/app_pages.dart';

class ListSavedNews extends StatelessWidget {
  const ListSavedNews({super.key, required this.savedNews});
  final List<SavedNewsModel> savedNews;
  @override
  Widget build(BuildContext context) {
    return savedNews.isEmpty
        ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedBlackHole,
                color: primaryColor(context: context),
                size: 100,
              ),
              Gap(20),
              Text('Tidak ada berita tersimpan'),
            ],
          ),
        )
        : ListView.separated(
          padding: EdgeInsets.all(20),
          itemCount: savedNews.length,
          separatorBuilder: (context, index) => Gap(20),
          itemBuilder: (context, index) {
            SavedNewsModel model = savedNews[index];
            return Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Data modelNews = Data(
                    title: model.title,
                    description: model.description,
                    image: model.image,
                    link: "https://antaranews.com${model.pathNews}",
                    isoDate: '',
                  );
                  Get.toNamed(
                    Routes.DETAIL_NEWS,
                    arguments: {'news_model': modelNews},
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(model.image!),
                      ),
                      Gap(8),
                      Text(
                        model.title,
                        style: titleLarge(
                          context: context,
                        )?.copyWith(color: primaryColor(context: context)),
                      ),
                      Gap(4),
                      Text(
                        model.description!,
                        style: bodyNormal(context: context)?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
