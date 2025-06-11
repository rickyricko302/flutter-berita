import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:info_a1/app/routes/app_pages.dart';

import '../../../../../core/util.dart';
import '../../../../data/model/headlines_news_model.dart';

class ListNews extends StatelessWidget {
  const ListNews({super.key, required this.listNews, required this.isLoading});
  final HeadlinesNewsModel? listNews;
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
              itemCount: listNews?.articles?.length ?? 0,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder:
                  (context, index) => Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.DETAIL_NEWS,
                          arguments: {'news_model': listNews?.articles?[index]},
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
                              child: CachedNetworkImage(
                                imageUrl:
                                    listNews?.articles?[index].urlToImage ??
                                    '-',
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
                                    listNews?.articles?[index].title ?? '-',
                                    style: titleLarge(context: context),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(listNews?.articles?[index].time ?? '-'),
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
