import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/app/modules/home/views/home_view.dart';
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
        children: [HomeView(), Text("Bookmark"), Text("Profile")],
      ),
      bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          backgroundColor: Colors.white,
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
              title: Text("Tersimpan"),
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
    );
  }
}
