class VideoNewsModel {
  final String videoId;
  final String title;
  final String channelName;
  final String? thumbnail;
  final bool isLive;

  VideoNewsModel({
    required this.videoId,
    required this.title,
    required this.channelName,
    required this.thumbnail,
    this.isLive = false,
  });

  // generate from json
  factory VideoNewsModel.fromJson(Map<String, dynamic> json) {
    return VideoNewsModel(
      videoId: json['video_id'],
      title: json['title'],
      channelName: json['channel_name'],
      thumbnail: json['thumbnail'],
      isLive: json['is_live'] ?? false,
    );
  }
}
