import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/providers/core/services/dashboard_carousel_provider.dart';

class HomeCarousel extends ConsumerStatefulWidget {
  const HomeCarousel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeCarouselState();
}

class HomeCarouselState extends ConsumerState<HomeCarousel> {
  final CarouselController carouselController = CarouselController(
    initialItem: 1,
  );

  @override
  Widget build(BuildContext context) {
    final List<String> carouselImages = ref.read(
      dashboardCarouselProviderProvider,
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      constraints: const BoxConstraints(maxHeight: 200),
      child: CarouselView.weighted(
        controller: carouselController,
        flexWeights: [1, 7, 1],
        enableSplash: true,
        itemSnapping: true,
        children: List.generate(
          carouselImages.length,
          (index) => Image.network(carouselImages[index], fit: BoxFit.cover),
        ),
      ),
    );
  }
}
