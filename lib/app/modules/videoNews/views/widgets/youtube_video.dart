import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/app/data/model/video_news_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../core/util.dart';

class YoutubeVideoWidget extends StatefulWidget {
  const YoutubeVideoWidget({super.key, required this.videoNewsModel});
  final VideoNewsModel videoNewsModel;
  @override
  State<YoutubeVideoWidget> createState() => _YoutubeVideoWidgetState();
}

class _YoutubeVideoWidgetState extends State<YoutubeVideoWidget> {
  late YoutubePlayerController youtubePlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoNewsModel.videoId,
      flags: const YoutubePlayerFlags(
        isLive: true,
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(16), child: SizedBox()),
        Gap(12),
        Obx(() => Text("", style: titleLarge(context: context))),
        Gap(4),
        Row(
          spacing: 8,
          children: [
            CircleAvatar(
              radius: 16,
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedUser03,
                size: 16,
                color: primaryColor(context: context),
              ),
            ),
            Obx(() => Text("", style: labelLarge(context: context))),
          ],
        ),
      ],
    );
  }
}
