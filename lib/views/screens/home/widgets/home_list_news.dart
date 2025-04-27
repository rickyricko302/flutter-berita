import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/utils/helper.dart';
import 'package:udb_news/views/screens/detail_news/detail_news_screen.dart';

import '../../../../core/models/news_model.dart';
import '../../../../providers/core/services/news_services_provider.dart';

class HomeListNews extends ConsumerWidget {
  const HomeListNews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<NewsModel> newsProvider = ref.read(newsServicesProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berita Terbaru Universitas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.blue.shade900,

              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: newsProvider.length,
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemBuilder: (context, index) {
              final NewsModel data = newsProvider[index];
              return Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    Helper.pushPage(
                      context: context,
                      page: DetailNewsScreen(data: data),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      spacing: 12,
                      children: [
                        Hero(
                          tag: "thumb-${data.thumbnail}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              data.thumbnail!,
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.title}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${data.date}",
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
