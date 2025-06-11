import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/app/modules/videoNews/views/video_news_view.dart';
import 'package:info_a1/app/modules/home/views/home_view.dart';
import 'package:info_a1/app/modules/profile/views/profile_view.dart';
import 'package:info_a1/app/modules/savedNews/views/saved_news_view.dart';
import 'package:info_a1/core/util.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [HomeView(), SavedNewsView(), VideoNewsView(), ProfileView()],
      ),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: !controller.videoFullscreen,
          child: SalomonBottomBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            currentIndex: controller.getIndexActive,
            onTap: (index) => controller.changeIndexActive(index: index),
            items: [
              SalomonBottomBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  color: primaryColor(context: context),
                ),
                title: Text("Beranda"),
              ),
              SalomonBottomBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedBookmark01,
                  color: primaryColor(context: context),
                ),
                title: Text(
                  "Tersimpan",
                  style: TextStyle(color: primaryColor(context: context)),
                ),
              ),
              SalomonBottomBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedYoutube,
                  color: primaryColor(context: context),
                ),
                title: Text("Berita Video"),
              ),
              SalomonBottomBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedProfile,
                  color: primaryColor(context: context),
                ),
                title: Text("Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
