import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'remember_me.g.dart';

@riverpod
class RememberMe extends _$RememberMe {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
