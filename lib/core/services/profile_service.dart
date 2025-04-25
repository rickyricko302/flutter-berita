import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:udb_news/core/models/profile_model.dart';
import 'package:udb_news/core/services/api_service.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  final ApiService apiService;

  ProfileService({required this.apiService});

  Future<ProfileModel> getProfile() async {
    final Uri url = Uri.parse('${apiService.baseUrl}/auth/me');
    final headers = await apiService.headerWithToken();
    final response = await http.get(url, headers: headers);
    debugPrint(response.request?.url.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw (json['message']);
    }
    return ProfileModel.fromJson(json);
  }
}
