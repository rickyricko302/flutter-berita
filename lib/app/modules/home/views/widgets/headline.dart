import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:info_a1/app/data/model/news_model.dart';
import 'package:info_a1/app/routes/app_pages.dart';

import '../../../../../core/util.dart';

class HeadLineWidget extends StatelessWidget {
  const HeadLineWidget({super.key, required this.headlineNews});
  final NewsModel? headlineNews;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Headline Berita",
          style: titleLarge(
            context: context,
          )?.copyWith(color: primaryColor(context: context)),
        ),
        Gap(4),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FlutterCarousel.builder(
            itemCount: 5,
            itemBuilder:
                (context, index, realIndex) => InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.DETAIL_NEWS,
                      parameters: {
                        'url_berita': headlineNews?.data?[index].link ?? '',
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(
                          headlineNews?.data?[index].image ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              headlineNews?.data?[index].time ?? '-',
                              style: bodySmall(context: context)?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              headlineNews?.data?[index].title ?? '-',
                              style: titleLarge(
                                context: context,
                              )?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            options: FlutterCarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.ease,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              slideIndicator: CircularSlideIndicator(
                slideIndicatorOptions: SlideIndicatorOptions(
                  indicatorRadius: 5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
