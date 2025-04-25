// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:udb_news/core/models/user_model.dart';
import 'package:udb_news/core/services/api_service.dart';
import 'package:udb_news/core/services/local_storage_service.dart';

class AuthService {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  AuthService({required this.apiService, required this.localStorageService});
  Future<UserModel> login({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    final url = Uri.parse('${apiService.baseUrl}/auth/login');
    final expiredRememberInMinute = 60 * 24; // 24 jam
    final response = await http.post(
      url,
      body: jsonEncode({
        'username': email,
        'password': password,
        'expiresInMins': isRememberMe ? expiredRememberInMinute : null,
      }),
      headers: apiService.headerWithoutToken(),
    );
    debugPrint(response.request?.url.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw (json['message']);
    }

    final String token = json['accessToken'];
    await localStorageService.write(key: 'accessToken', value: token);

    return UserModel.fromJson(json);
  }
}
