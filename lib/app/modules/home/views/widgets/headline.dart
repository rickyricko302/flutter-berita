import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';

import '../../../../../core/util.dart';

class HeadLineWidget extends StatelessWidget {
  const HeadLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Headline Berita", style: titleLarge(context: context)),
        Gap(4),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FlutterCarousel.builder(
            itemCount: 5,
            itemBuilder:
                (context, index, realIndex) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://img.antaranews.com/cache/800x533/2024/01/25/ps-5_1.jpeg',
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
                          decoration: BoxDecoration(color: Colors.black45),
                          child: Text(
                            "2 Jam lalu",
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
                            "Kenali 5 masalah umum di konsol PS4 dan PS5 serta cara mengatasinya",
                            style: titleLarge(
                              context: context,
                            )?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            options: FlutterCarouselOptions(
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
