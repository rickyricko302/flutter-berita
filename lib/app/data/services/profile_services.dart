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
  Future<void> updateProfile({required UpdateProfileModel profileModel}) async {
    return await remoteDatabaseService.updateProfile(
      profileModel: profileModel,
      userId: uid!,
    );
  }

  /*************  ✨ Windsurf Command ⭐  *************/
  /// Uploads a new image to the remote storage and updates the associated user profile.
  ///
  /// Takes a [String] containing the ID of the user profile to update, and a [File]
  /// containing the image data to upload.
  ///
  /// Returns a [Future] which completes when the image has been successfully uploaded
  /// and the user profile has been updated.
  ///
  /// Throws an error if the upload or update operations fail.
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
