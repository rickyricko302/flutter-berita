import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/util.dart';

class ListNews extends StatelessWidget {
  const ListNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(30),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemBuilder:
              (context, index) => Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        "https://img.antaranews.com/cache/800x533/2020/12/18/PS5-at-UR.jpeg",
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
                            "Kenali 5 masalah umum di konsol PS4 dan PS5 serta cara mengatasinya",
                            style: titleLarge(context: context),
                          ),
                          Text("2 jam lalu"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ],
    );
  }
}
