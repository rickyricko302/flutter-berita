import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controller_provider.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  int build() {
    return 0;
  }

  void changeIndex({required int index}) {
    state = index;
  }
}
