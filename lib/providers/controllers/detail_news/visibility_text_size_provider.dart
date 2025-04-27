import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visibility_text_size_provider.g.dart';

@riverpod
class VisibilityTextSizeProvider extends _$VisibilityTextSizeProvider {
  @override
  bool build() {
    return false;
  }

  void toggleVisibility() {
    state = !state;
  }
}
