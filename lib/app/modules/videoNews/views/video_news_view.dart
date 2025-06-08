import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/app/data/model/video_news_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/util.dart';
import '../controllers/video_news_controller.dart';

class VideoNewsView extends GetView<VideoNewsController> {
  const VideoNewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          toolbarHeight: controller.isFullScreen ? 0 : kToolbarHeight,
          title: Text('Berita Video', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: primaryColor(context: context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        body: Obx(
          () =>
              controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(children: [_buildYoutubePlayer(context: context)]),
        ),
      ),
    );
  }

  _buildYoutubePlayer({required BuildContext context}) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller.youtbeController,
        showVideoProgressIndicator: true,
      ),
      onEnterFullScreen: () => controller.setFullScreen(true),
      onExitFullScreen: () => controller.setFullScreen(false),
      builder: (p0, player) {
        return Padding(
          padding: EdgeInsets.all(controller.isFullScreen ? 0 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  controller.isFullScreen ? 0 : 16,
                ),
                child: player,
              ),
              Visibility(
                visible: !controller.isFullScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(12),
                    Obx(
                      () => Text(
                        controller.selectedVideo?.title ?? '-',
                        style: titleLarge(context: context),
                      ),
                    ),
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
                        Obx(
                          () => Text(
                            controller.selectedVideo?.channelName ?? '-',
                            style: labelLarge(context: context),
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.videoModel.length,
                      itemBuilder: (context, index) {
                        VideoNewsModel model = controller.videoModel[index];
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.setSelectedVideo(model);
                              controller.reloadYoutubeVideo();
                            },
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity:
                                  model.videoId ==
                                          (controller.selectedVideo?.videoId ??
                                              '')
                                      ? .5
                                      : 1,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        model.thumbnail ?? '-',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Gap(12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.title,
                                            style: titleLarge(context: context),
                                          ),
                                          Gap(4),
                                          Row(
                                            children: [
                                              HugeIcon(
                                                icon:
                                                    HugeIcons
                                                        .strokeRoundedYoutube,
                                                color: primaryColor(
                                                  context: context,
                                                ),
                                              ),
                                              Gap(8),
                                              Text(
                                                model.channelName,
                                                style: labelLarge(
                                                  context: context,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
