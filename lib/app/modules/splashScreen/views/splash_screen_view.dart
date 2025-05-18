import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SplashScreenView'), centerTitle: true),
      body: Center(
        child: Text(
          'SplashScreenView is working ${controller.toString()}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
