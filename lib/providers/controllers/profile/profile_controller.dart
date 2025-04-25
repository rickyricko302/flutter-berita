import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/models/profile_model.dart';
import 'package:udb_news/core/repositories/profile_repository.dart';
import 'package:udb_news/providers/core/repositories/profile_repository_provider.dart';

import '../../../core/utils/helper.dart';
import '../../../views/screens/login_screen.dart';
part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<ProfileModel?> build() => null;

  Future<void> getProfile() async {
    state = AsyncLoading();
    try {
      final ProfileRepositoryImpl profileRepositoryImpl = ref.read(
        profileRepositoryProvider,
      );
      final ProfileModel data = await profileRepositoryImpl.getProfile();
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  void logout({required BuildContext context}) {
    Helper.backFirstPage(context: context);
    Helper.pushPage(context: context, page: LoginScreen());
  }
}
