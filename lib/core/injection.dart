import "package:get/get.dart";
import "package:info_a1/app/data/services/auth_services.dart";
import "package:info_a1/app/data/services/news_services.dart";
import "package:info_a1/app/data/services/pick_image_service.dart";
import "package:info_a1/app/data/services/profile_services.dart";
import "package:info_a1/app/data/services/remote_database_service.dart";
import "package:info_a1/app/data/services/remote_storage_service.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class Injection {
  static void init() {
    Get.put(Supabase.instance.client);
    Get.put(RemoteDatabaseService(supabaseClient: Get.find()));
    Get.put(RemoteStorageService(supabaseClient: Get.find()));
    Get.put(
      AuthServices(
        supabaseClient: Get.find(),
        remoteDatabaseService: Get.find(),
      ),
    );
    Get.put(NewsServices(remoteDatabaseService: Get.find()));
    Get.put(
      ProfileServices(
        supabaseClient: Get.find(),
        remoteDatabaseService: Get.find(),
        remoteStorageService: Get.find(),
      ),
    );
    Get.put(PickImageService());
  }
}
