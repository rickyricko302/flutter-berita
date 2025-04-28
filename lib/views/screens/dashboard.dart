import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/utils/helper.dart';
import 'package:udb_news/providers/controllers/dashboards/dashboard_controller_provider.dart';
import 'package:udb_news/views/screens/about_udb.dart';
import 'package:udb_news/views/screens/home/home_screen.dart';
import 'package:udb_news/views/screens/profile_screen.dart';
import 'package:udb_news/views/shared_widgets/dashboard_bottom_nav.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    ref.listenManual(dashboardControllerProvider, (previous, next) {
      final int indexPage = next;
      _pageController.jumpToPage(indexPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: PageView(
        controller: _pageController,

        physics: NeverScrollableScrollPhysics(),
        children: [HomeScreen(), ProfileScreen(nama: 'Joko')],
      ),
      bottomNavigationBar: DashboardBottomNav(),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            Helper.pushPage(context: context, page: AboutUDBScreen());
          },
          child: Image.asset(
            Helper.readAssetImages(fileName: 'udb-logo.png'),
            width: 42,
            height: 42,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
