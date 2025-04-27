import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/providers/controllers/detail_news/text_size_provider.dart';
import 'package:udb_news/providers/controllers/detail_news/visibility_text_size_provider.dart';

class SliderTextSize extends ConsumerWidget {
  const SliderTextSize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSliderVisible = ref.watch(visibilityTextSizeProviderProvider);
    final double sliderValue = ref.watch(textSizeProvider);

    final sliderValueNotifier = ref.read(textSizeProvider.notifier);
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      curve: Curves.bounceOut,
      top: isSliderVisible ? 0 : -100,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        height: 48,
        child: Slider(
          value: sliderValue,
          onChanged: (value) {
            sliderValueNotifier.changeSize(value: value);
          },
        ),
      ),
    );
  }
}
