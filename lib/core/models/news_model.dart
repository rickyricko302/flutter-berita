class NewsModel {
  int? id;
  String? thumbnail;
  String? title;
  String? date;
  String? content;
  List<String>? extraPhoto;

  NewsModel({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.date,
    required this.content,
    this.extraPhoto,
  });
}
