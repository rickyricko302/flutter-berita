class ProfileModel {
  final String userId;
  final String name;
  final String? photoPath;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.photoPath,
  });

  factory ProfileModel.fromJson(json) {
    return ProfileModel(
      userId: json['user_id'],
      name: json['name'],
      photoPath: json['photo_path'],
    );
  }

  toJson() {
    return {'user_id': userId, 'name': name, "photo_path": photoPath};
  }
}
