// AddSavedNewsModel.dart
class AddSavedNewsModel {
  final String userId;
  final String pathNews;
  final String title;
  final String? image;
  final String? description;

  AddSavedNewsModel({
    required this.userId,
    required this.pathNews,
    required this.title,
    this.image,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'path_news': pathNews,
      'title': title,
      'image': image,
      'description': description,
    };
  }
}
