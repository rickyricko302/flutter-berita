import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/models/news_model.dart';
import 'package:udb_news/core/utils/helper.dart';
import 'package:udb_news/providers/core/services/news_services_provider.dart';
import 'package:udb_news/views/screens/detail_news/detail_news_screen.dart';

class OtherNews extends ConsumerWidget {
  const OtherNews({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<NewsModel> otherNews = ref
        .read(newsServicesProvider.notifier)
        .getTwoOtherNews(id: id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Berita Lainnya',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).secondaryHeaderColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: otherNews.length,
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemBuilder: (context, index) {
            final NewsModel data = otherNews[index];
            return Material(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Helper.replacePage(
                    context: context,
                    page: DetailNewsScreen(data: data),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .1),
                    ),
                  ),
                  child: Row(
                    spacing: 12,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          data.thumbnail!,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
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
    );
  }
}
