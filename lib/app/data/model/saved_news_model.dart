class SavedNewsModel {
  final int id;
  final String userId;
  final String pathNews;
  final String title;
  final String? image;
  final String? description;
  final DateTime createdAt;

  SavedNewsModel({
    required this.id,
    required this.userId,
    required this.pathNews,
    required this.title,
    this.image,
    this.description,
    required this.createdAt,
  });

  factory SavedNewsModel.fromJson(Map<String, dynamic> json) {
    return SavedNewsModel(
      id: json['id'],
      userId: json['user_id'],
      pathNews: json['path_news'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'path_news': pathNews,
      'title': title,
      'image': image,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
