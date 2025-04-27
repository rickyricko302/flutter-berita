import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/core/services/local_storage_service.dart';
import 'package:udb_news/providers/core/services/local_storage_provider.dart';

part 'text_size_provider.g.dart';

@riverpod
class TextSize extends _$TextSize {
  @override
  double build() {
    return 0;
  }

  void changeSize({required double value}) {
    state = value;
    _saveChanges();
  }

  void _saveChanges() {
    final LocalStorageService localStorageService = ref.read(
      localStorageProvider,
    );
    localStorageService.write(key: "font_size", value: state.toString());
  }

  Future<double> readTextSize() async {
    final LocalStorageService localStorageService = ref.read(
      localStorageProvider,
    );
    double size = double.parse(
      await localStorageService.read(key: 'font_size') ?? ".3",
    );
    state = size;
    return size;
  }
}
