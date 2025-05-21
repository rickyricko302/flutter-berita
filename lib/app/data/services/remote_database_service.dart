import 'dart:developer';

import 'package:info_a1/app/data/model/add_saved_news_model.dart';
import 'package:info_a1/app/data/model/update_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/profile_model.dart';
import '../model/saved_news_model.dart';

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

  // Insert saved news
  Future<void> insertSavedNews(AddSavedNewsModel news) async {
    try {
      await _supabaseClient.from("saved_news").insert(news.toJson());
    } catch (e) {
      throw Exception('Failed to insert saved news: $e');
    }
  }

  // Get all saved news by user ID
  Future<List<SavedNewsModel>> getSavedNewsByUserId(String userId) async {
    try {
      final response = await _supabaseClient
          .from("saved_news")
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((item) => SavedNewsModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to get saved news: $e');
    }
  }

  // Delete saved news by user ID and path
  Future<void> deleteSavedNews(String userId, String pathNews) async {
    try {
      await _supabaseClient.from("saved_news").delete().match({
        'user_id': userId,
        'path_news': pathNews,
      });
    } catch (e) {
      throw Exception('Failed to delete saved news: $e');
    }
  }

  // Check if a news is already saved by user
  Future<bool> isNewsSaved(String userId, String pathNews) async {
    try {
      final response = await _supabaseClient
          .from("saved_news")
          .select('id')
          .match({'user_id': userId, 'path_news': pathNews});

      return (response as List).isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check saved news: $e');
    }
  }
}
