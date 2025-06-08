import 'package:get/get.dart';
import 'package:info_a1/app/data/model/video_news_model.dart';
import 'package:info_a1/app/data/services/news_services.dart';
import 'package:info_a1/core/util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoNewsController extends GetxController {
  final RxList<VideoNewsModel> _videoModel = RxList([]);
  final RxBool _isLoading = false.obs;
  final RxBool _isFullScreen = false.obs;
  final Rxn<VideoNewsModel> _selectedVideo = Rxn<VideoNewsModel>();

  List<VideoNewsModel> get videoModel => _videoModel;
  VideoNewsModel? get selectedVideo => _selectedVideo.value;
  bool get isLoading => _isLoading.value;
  bool get isFullScreen => _isFullScreen.value;

  late YoutubePlayerController youtbeController;
  final NewsServices _newsServices = Get.find();

  @override
  void onInit() {
    super.onInit();
    getVideoNews();
  }

  /// Get all video news from the database.
  ///
  /// This method will make a request to the remote database to get all video
  /// news. If the request is successful, it will update the `videoModel` list
  /// with the result. If the request failed, it will show a snackbar error with
  /// the error message as the message.
  void getVideoNews() async {
    _isLoading.value = true;
    try {
      _videoModel.value = await _newsServices.getVideoNews();
      setSelectedVideo(_videoModel.first);
      youtbeController = YoutubePlayerController(
        initialVideoId: _selectedVideo.value!.videoId,
        flags: const YoutubePlayerFlags(
          isLive: true,
          autoPlay: false,
          mute: false,
        ),
      );
    } catch (e) {
      showSnackbarError("Gagal", e.toString());
    }
    _isLoading.value = false;
  }

  void setFullScreen(bool value) => _isFullScreen.value = value;
  void setSelectedVideo(VideoNewsModel model) => _selectedVideo.value = model;
  void reloadYoutubeVideo() {
    youtbeController.load(_selectedVideo.value!.videoId);
  }
}
