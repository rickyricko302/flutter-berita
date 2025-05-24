import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteStorageService {
  final SupabaseClient _supabaseClient;
  final String avatarBucker = "avatar";

  RemoteStorageService({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  /// Upload a new avatar image to Supabase storage.
  ///
  /// The avatar image is uploaded to the "avatar" bucket and is publicly accessible.
  ///
  /// [uid] is the user ID associated with the avatar image.
  ///
  /// [file] is the avatar image file to be uploaded.
  ///
  /// The function returns the public URL of the uploaded avatar image.
  ///
  /// Throws [SupabaseException] if there is an error uploading the image.
  Future<String> uploadNewImage({
    required String uid,
    required File file,
  }) async {
    await _supabaseClient.storage.from(avatarBucker).update(uid, file);
    return _supabaseClient.storage.from("avatar").getPublicUrl(uid);
  }
}
