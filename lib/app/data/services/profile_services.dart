import 'dart:io';

import 'package:info_a1/app/data/model/update_profile_model.dart';
import 'package:info_a1/app/data/services/remote_database_service.dart';
import 'package:info_a1/app/data/services/remote_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileServices {
  final SupabaseClient supabaseClient;
  final RemoteDatabaseService remoteDatabaseService;
  final RemoteStorageService remoteStorageService;

  String? get uid => supabaseClient.auth.currentUser?.id;

  ProfileServices({
    required this.supabaseClient,
    required this.remoteDatabaseService,
    required this.remoteStorageService,
  });

  /*************  ✨ Windsurf Command ⭐  *************/
  /// Updates the user profile in the remote database using the provided profile model.
  ///
  /// Takes an [UpdateProfileModel] containing the updated profile details,
  /// and updates the profile associated with the current user's ID.
  ///
  /// Throws an error if the update operation fails.

  /*******  132beccc-6d4a-445d-a82c-f22dad36872c  *******/
  Future<void> updateProfile({required UpdateProfileModel profileModel}) async {
    return await remoteDatabaseService.updateProfile(
      profileModel: profileModel,
      userId: uid!,
    );
  }

  Future<void> uploadNewImage({required String uid, required File file}) async {
    final String publicPath = await remoteStorageService.uploadNewImage(
      uid: uid,
      file: file,
    );
    return await remoteDatabaseService.updatePhotoPath(
      userId: uid,
      path: publicPath,
    );
  }
}
