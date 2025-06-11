import 'dart:convert';
import 'dart:developer';

import 'package:info_a1/app/data/model/headlines_news_model.dart';
import 'package:info_a1/app/data/model/update_profile_model.dart';
import 'package:info_a1/app/data/model/video_news_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/profile_model.dart';
import '../model/saved_news_model.dart';

class RemoteDatabaseService {
  final SupabaseClient _supabaseClient;

  RemoteDatabaseService({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  // Update profiles
  Future<void> insertProfiles({required ProfileModel model}) async {
    await _supabaseClient.from("profiles").insert(model.toJson());
  }

  // Get profile with return model
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

  // update profile ex: phone, address
  Future<void> updateProfile({
    required UpdateProfileModel profileModel,
    required String userId,
  }) async {
    await _supabaseClient
        .from('profiles')
        .update(profileModel.toJson())
        .eq('user_id', userId);
  }

  // Update Photo
  Future<void> updatePhotoPath({
    required String userId,
    required String path,
  }) async {
    await _supabaseClient
        .from('profiles')
        .update({'photo_path': path})
        .eq('user_id', userId);
  }

  // Insert saved news
  Future<void> insertSavedNews(String userId, Articles news) async {
    try {
      // create new map to insert user_id on news.toJson
      Map<String, dynamic> newsMap = news.toJson();
      newsMap['user_id'] = userId;
      await _supabaseClient.from("saved_news").insert(newsMap);
    } catch (e) {
      throw Exception('Failed to insert saved news: $e');
    }
  }

  // Get all saved news by user ID
  Future<List<Articles>> getSavedNewsByUserId(String userId) async {
    try {
      final response = await _supabaseClient
          .from("saved_news")
          .select()
          .eq('user_id', userId);
      return (response as List).map((item) => Articles.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to get saved news: $e');
    }
  }

  // Delete saved news by user ID and path
  Future<void> deleteSavedNews(String userId, String title) async {
    try {
      await _supabaseClient.from("saved_news").delete().match({
        'user_id': userId,
        'title': title,
      });
    } catch (e) {
      throw Exception('Failed to delete saved news: $e');
    }
  }

  // Check if a news is already saved by user
  Future<bool> isNewsSaved(String userId, String title) async {
    try {
      final response = await _supabaseClient
          .from("saved_news")
          .select('id')
          .match({'user_id': userId, 'title': title});

      return (response as List).isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check saved news: $e');
    }
  }

  // get video news
  // Get all saved news by user ID
  Future<List<VideoNewsModel>> getVideoNews() async {
    try {
      final response = await _supabaseClient.from("youtube").select();
      print(response.toString());
      return (response as List)
          .map((item) => VideoNewsModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to get video news: $e');
    }
  }
}
