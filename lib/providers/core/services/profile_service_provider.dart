import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/services/api_service.dart';
import 'package:udb_news/core/services/profile_service.dart';
import 'package:udb_news/providers/core/services/api_service_provider.dart';

part 'profile_service_provider.g.dart';

@riverpod
ProfileService profileService(Ref ref) {
  final ApiService apiService = ref.read(apiServiceProvider);
  return ProfileService(apiService: apiService);
}
