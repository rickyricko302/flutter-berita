import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/repositories/profile_repository.dart';
import 'package:udb_news/core/services/profile_service.dart';
import 'package:udb_news/providers/core/services/profile_service_provider.dart';
part 'profile_repository_provider.g.dart';

@riverpod
ProfileRepositoryImpl profileRepository(Ref ref) {
  final ProfileService profileService = ref.read(profileServiceProvider);
  return ProfileRepositoryImpl(profileService: profileService);
}
