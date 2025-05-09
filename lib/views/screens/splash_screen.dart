import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/utils/constants.dart';
import 'package:udb_news/core/utils/helper.dart';
import 'package:udb_news/providers/core/services/auth_service_provider.dart';
import 'package:udb_news/views/screens/dashboard_screen.dart';
import 'package:udb_news/views/screens/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isAnimated = false;
  bool isIconAnimated = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isAnimated = true;
      });
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        isIconAnimated = true;
      });
    });
    Future.delayed(Duration(seconds: 5), () async {
      final bool isLogged = await ref.read(authServiceProvider).isUserLogged();
      Helper.replacePage(
        // ignore: use_build_context_synchronously
        context: context,
        page: isLogged ? DashboardScreen() : LoginScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(context: context),
      body: Stack(
        children: [
          Positioned(
            top: -200,
            left: -200,
            right: -200,
            bottom: -200,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.ease,
                width: isAnimated ? 2000 : 0,
                height: isAnimated ? 2000 : 0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2000),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child:
                  isIconAnimated
                      ? Image.asset(
                        Helper.readAssetImages(fileName: 'udb-with-text.png'),
                        width: 200,
                        height: 200,
                      )
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
