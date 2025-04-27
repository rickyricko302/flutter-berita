import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/models/news_model.dart';
import 'package:udb_news/core/utils/constants.dart';
import 'package:udb_news/providers/controllers/detail_news/text_size_provider.dart';
import 'package:udb_news/providers/controllers/detail_news/visibility_text_size_provider.dart';
import 'package:udb_news/views/screens/detail_news/other_news.dart';
import 'package:udb_news/views/shared_widgets/custom_app_bar.dart';
import 'package:udb_news/views/shared_widgets/slider_text_size.dart';

class DetailNewsScreen extends ConsumerStatefulWidget {
  const DetailNewsScreen({super.key, required this.data});
  final NewsModel data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailNewsScreenState();
}

class _DetailNewsScreenState extends ConsumerState<DetailNewsScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await ref.read(textSizeProvider.notifier).readTextSize();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSliderVisible = ref.watch(visibilityTextSizeProviderProvider);
    final visibilityTextSizeNotifier = ref.read(
      visibilityTextSizeProviderProvider.notifier,
    );
    final textSize = ref.watch(textSizeProvider);
    return Scaffold(
      appBar: CustomAppbar(
        title: "Detail Berita",
        suffix: IconButton(
          onPressed: () {
            visibilityTextSizeNotifier.toggleVisibility();
          },
          style: IconButton.styleFrom(
            backgroundColor:
                isSliderVisible ? Colors.grey.shade200 : Colors.transparent,
          ),
          icon: Icon(Icons.format_size, color: primaryColor(context: context)),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "thumb-${widget.data.thumbnail}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(widget.data.thumbnail!),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${widget.data.title}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${widget.data.content}",
                    style: TextStyle(fontSize: textSize * 48),
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.data.extraPhoto?.length ?? 0,
                    separatorBuilder:
                        (context, index) => Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey[200],
                          margin: EdgeInsets.only(bottom: 10, top: 4),
                        ),
                    itemBuilder:
                        (context, index) => Column(
                          children: [
                            Image.network(widget.data.extraPhoto![index]),
                            Text(
                              'Dokumentasi ${index + 1}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                  ),
                  OtherNews(id: widget.data.id!),
                ],
              ),
            ),
          ),
          SliderTextSize(),
        ],
      ),
    );
  }
}
