import 'dart:convert';

import 'package:info_a1/app/data/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:info_a1/app/data/services/remote_database_service.dart';

import '../model/add_saved_news_model.dart';
import '../model/saved_news_model.dart';

class NewsServices {
  final RemoteDatabaseService _remoteDatabaseService;
  final String _baseUrl =
      "https://berita-indo-api-next.vercel.app/api/antara-news";

  NewsServices({required RemoteDatabaseService remoteDatabaseService})
    : _remoteDatabaseService = remoteDatabaseService;

  /// Get headline news from API.
  ///
  /// This method will make a GET request to $_baseUrl/terkini and return
  /// a [NewsModel] object. If the response status code is not 200, it will
  /// throw an exception with the response body as the message.
  Future<NewsModel> getHeadlineNews() async {
    final res = await http.get(Uri.parse("$_baseUrl/terkini"));
    final json = jsonDecode(res.body);
    if (res.statusCode != 200) {
      throw (res.body);
    }
    print(json);
    final NewsModel model = NewsModel.fromJson(json);
    return model;
  }

  /// Get news with specific category.
  ///
  /// This method will make a GET request to $_baseUrl/[category] and return
  /// a [NewsModel] object. If the response status code is not 200, it will
  /// throw an exception with the response body as the message.
  Future<NewsModel> getNewsWithCategory({required String category}) async {
    final res = await http.get(Uri.parse("$_baseUrl/$category"));
    final json = jsonDecode(res.body);
    if (res.statusCode != 200) {
      throw (res.body);
    }
    final NewsModel model = NewsModel.fromJson(json);
    return model;
  }

  /// Check if the news with specific [pathNews] is saved by the user with specific [userId].
  ///
  /// This method will make a request to the remote database to check if the news with
  /// [pathNews] is saved by the user with [userId]. If the news is saved, it will
  /// return true. If the news is not saved, it will return false.
  Future<bool> isNewsSaved(String userId, String pathNews) async {
    return await _remoteDatabaseService.isNewsSaved(userId, pathNews);
  }

  /// Insert saved news to the database.
  ///
  /// This method will make a request to the remote database to insert the
  /// [AddSavedNewsModel] object as a saved news. If the request is successful,
  /// it will return true. If the request failed, it will throw an exception
  /// with the error message as the message.
  Future<void> insertSavedNews(AddSavedNewsModel news) async {
    return await _remoteDatabaseService.insertSavedNews(news);
  }

  /// Delete saved news from the database.
  ///
  /// This method will make a request to the remote database to delete the
  /// saved news with [pathNews] saved by the user with [userId]. If the
  /// request is successful, it will return true. If the request failed, it
  /// will throw an exception with the error message as the message.
  Future<void> deleteSavedNews(String userId, String pathNews) async {
    return await _remoteDatabaseService.deleteSavedNews(userId, pathNews);
  }

  /// Get all saved news by user with specific [userId].
  ///
  /// This method will make a request to the remote database to get all saved
  /// news by the user with [userId]. If the request is successful, it will
  /// return a list of [SavedNewsModel] objects. If the request failed, it
  /// will throw an exception with the error message as the message.
  Future<List<SavedNewsModel>> getSavedNewsByUserId(String userId) async {
    return await _remoteDatabaseService.getSavedNewsByUserId(userId);
  }
}
