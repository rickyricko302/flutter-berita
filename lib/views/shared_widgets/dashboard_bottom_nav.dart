import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/utils/constants.dart';
import 'package:udb_news/providers/controllers/dashboards/dashboard_controller_provider.dart';

class DashboardBottomNav extends ConsumerWidget {
  const DashboardBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexActive = ref.watch(dashboardControllerProvider);
    final dashboardControllerNotifier = ref.read(
      dashboardControllerProvider.notifier,
    );
    return AnimatedBottomNavigationBar.builder(
      gapLocation: GapLocation.center,
      itemCount: 2,
      backgroundColor: primaryColor(context: context),
      notchMargin: 12,
      tabBuilder: (index, isActive) {
        if (index == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home_outlined, color: Colors.white),
              Text(
                'Beranda',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      indexActive == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_outline, color: Colors.white),
            Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight:
                    indexActive == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      },
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      activeIndex: 0,
      onTap: (index) {
        dashboardControllerNotifier.changeIndex(index: index);
      },
    );
  }
}
