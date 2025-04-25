import 'package:udb_news/core/services/local_storage_service.dart';

class ApiService {
  final LocalStorageService localStorageService;
  final String baseUrl = 'https://dummyjson.com';

  ApiService({required this.localStorageService});

  Map<String, String> headerWithoutToken() {
    return {'Content-Type': 'application/json'};
  }

  Future<Map<String, String>> headerWithToken() async {
    final String token = await localStorageService.read(key: 'token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
