import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/core/util.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(context: context),
      body: Obx(
        () => Stack(
          children: [
            Positioned(
              top: -200,
              bottom: -200,
              right: -200,
              left: -200,
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: controller.isAnimated ? 2000 : 0,
                  height: controller.isAnimated ? 2000 : 0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(99999),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedNews,
                    color: primaryColor(context: context),
                    size: 100,
                  ),
                  Text(
                    "Info A1",
                    style: displayLarge(
                      context: context,
                    )?.copyWith(color: primaryColor(context: context)),
                  ),
                  Text(
                    'author: Ricky V',
                    style: bodySmall(
                      context: context,
                    )?.copyWith(color: primaryColor(context: context)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
