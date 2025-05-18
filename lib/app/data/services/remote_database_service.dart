import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/profile_model.dart';

class RemoteDatabaseService {
  final SupabaseClient _supabaseClient;

  RemoteDatabaseService({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  Future<void> insertProfiles({required ProfileModel model}) async {
    return await _supabaseClient.from("profiles").insert(model.toJson());
  }

  Future<ProfileModel?> getProfile({required String userId}) async {
    final Map? profile =
        await _supabaseClient
            .from('profiles')
            .select()
            .eq('user_id', userId)
            .maybeSingle();
    if (profile != null) {
      log("profilenya $profile");
      return ProfileModel.fromJson(profile);
    }
    return null;
  }
}
