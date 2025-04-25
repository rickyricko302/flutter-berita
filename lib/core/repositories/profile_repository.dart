import 'package:udb_news/core/models/profile_model.dart';

import '../services/profile_service.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService _profileService;

  ProfileRepositoryImpl({required ProfileService profileService})
    : _profileService = profileService;
  @override
  Future<ProfileModel> getProfile() async {
    return await _profileService.getProfile();
  }
}
