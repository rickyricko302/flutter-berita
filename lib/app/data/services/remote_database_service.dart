import 'dart:developer';

import 'package:info_a1/app/data/model/update_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/profile_model.dart';

class RemoteDatabaseService {
  final SupabaseClient _supabaseClient;

  RemoteDatabaseService({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  Future<void> insertProfiles({required ProfileModel model}) async {
    await _supabaseClient.from("profiles").insert(model.toJson());
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

  Future<void> updateProfile({
    required UpdateProfileModel profileModel,
    required String userId,
  }) async {
    await _supabaseClient
        .from('profiles')
        .update(profileModel.toJson())
        .eq('user_id', userId);
  }
}
