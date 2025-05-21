import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:info_a1/app/modules/home/controllers/home_controller.dart';

import '../../../../../core/util.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(30),
        Text(
          "Kategori Berita",
          style: titleLarge(
            context: context,
          )?.copyWith(color: primaryColor(context: context)),
        ),
        Gap(4),
        SizedBox(
          height: 40,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemBuilder:
                (context, index) => Obx(
                  () => TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      elevation: 0,
                      backgroundColor:
                          index == controller.getCategoryActive
                              ? primaryColor(context: context)
                              : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: primaryColor(context: context)),
                      ),
                    ),
                    onPressed: () {
                      controller.changeCategoryActive(index: index);
                    },
                    child: Text(
                      controller.categories[index],
                      style: TextStyle(
                        color:
                            index == controller.getCategoryActive
                                ? Colors.white
                                : null,
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
