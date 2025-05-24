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

  Future<NewsModel> getNewsWithCategory({required String category}) async {
    final res = await http.get(Uri.parse("$_baseUrl/$category"));
    final json = jsonDecode(res.body);
    if (res.statusCode != 200) {
      throw (res.body);
    }
    final NewsModel model = NewsModel.fromJson(json);
    return model;
  }

  Future<bool> isNewsSaved(String userId, String pathNews) async {
    return await _remoteDatabaseService.isNewsSaved(userId, pathNews);
  }

  Future<void> insertSavedNews(AddSavedNewsModel news) async {
    return await _remoteDatabaseService.insertSavedNews(news);
  }

  Future<void> deleteSavedNews(String userId, String pathNews) async {
    return await _remoteDatabaseService.deleteSavedNews(userId, pathNews);
  }

  Future<List<SavedNewsModel>> getSavedNewsByUserId(String userId) async {
    return await _remoteDatabaseService.getSavedNewsByUserId(userId);
  }
}
