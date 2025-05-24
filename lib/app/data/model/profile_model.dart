class ProfileModel {
  final String userId;
  final String name;
  final String? photoPath;
  final String? phone;
  final String? address;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.photoPath,
    this.phone,
    this.address,
  });

  factory ProfileModel.fromJson(json) {
    return ProfileModel(
      userId: json['user_id'],
      name: json['name'],
      photoPath: json['photo_path'] + "?v=${DateTime.timestamp()}",
      phone: json['phone'],
      address: json['address'],
    );
  }

  toJson() {
    return {
      'user_id': userId,
      'name': name,
      "photo_path": photoPath,
      "phone": phone,
      "address": address,
    };
  }
}
