class UpdateProfileModel {
  final String? name;
  final String? phone;
  final String? address;

  UpdateProfileModel({
    required this.name,
    required this.phone,
    required this.address,
  });

  toJson() {
    return {"name": name, "phone": phone, "address": address};
  }
}
