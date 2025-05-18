import 'package:info_a1/app/data/model/update_profile_model.dart';
import 'package:info_a1/app/data/services/remote_database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileServices {
  final SupabaseClient supabaseClient;
  final RemoteDatabaseService remoteDatabaseService;

  String? get uid => supabaseClient.auth.currentUser?.id;

  ProfileServices({
    required this.supabaseClient,
    required this.remoteDatabaseService,
  });

  Future<void> updateProfile({required UpdateProfileModel profileModel}) async {
    return await remoteDatabaseService.updateProfile(
      profileModel: profileModel,
      userId: uid!,
    );
  }
}
