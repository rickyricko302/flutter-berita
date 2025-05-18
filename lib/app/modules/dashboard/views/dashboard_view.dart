import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/core/util.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DashboardView'), centerTitle: true),
      body: Center(
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedAddCircleHalfDot,
          color: primaryColor(context: context),
          size: 30,
        ),
      ),
    );
  }
}
