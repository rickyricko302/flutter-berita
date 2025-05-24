import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteStorageService {
  final SupabaseClient _supabaseClient;
  final String avatarBucker = "avatar";

  RemoteStorageService({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  Future<String> uploadNewImage({
    required String uid,
    required File file,
  }) async {
    await _supabaseClient.storage.from(avatarBucker).update(uid, file);
    return _supabaseClient.storage.from("avatar").getPublicUrl(uid);
  }
}
