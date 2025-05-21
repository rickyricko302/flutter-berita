import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:info_a1/app/data/model/news_model.dart';
import 'package:info_a1/app/routes/app_pages.dart';

import '../../../../../core/util.dart';

class ListNews extends StatelessWidget {
  const ListNews({super.key, required this.listNews, required this.isLoading});
  final NewsModel? listNews;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Center(child: CircularProgressIndicator()),
        )
        : Column(
          children: [
            Gap(20),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listNews?.total ?? 0,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder:
                  (context, index) => Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.DETAIL_NEWS,
                          parameters: {
                            'url_berita': listNews?.data?[index].link ?? '',
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                listNews?.data?[index].image ?? '-',
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listNews?.data?[index].title ?? '-',
                                    style: titleLarge(context: context),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(listNews?.data?[index].time ?? '-'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ),
          ],
        );
  }
}
