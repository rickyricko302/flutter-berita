import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/views/screens/home/widgets/home_agenda.dart';
import 'package:udb_news/views/screens/home/widgets/home_list_news.dart';
import 'package:udb_news/views/shared_widgets/custom_app_bar.dart';

import 'widgets/home_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Universitas Duta Bangsa'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeCarousel(),
            const SizedBox(height: 10),
            HomeListNews(),
            const SizedBox(height: 30),
            HomeAgenda(),
            const SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
}
