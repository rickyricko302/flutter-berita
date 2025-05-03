import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udb_news/providers/core/services/local_storage_provider.dart';
part 'theme_provider.g.dart';

@riverpod
class ThemeToggle extends _$ThemeToggle {
  @override
  Future<ThemeMode> build() async {
    final ThemeMode themeMode = await _readTheme();
    return themeMode;
  }

  Future<void> toggleTheme() async {
    state = AsyncValue.data(
      await _isDarkMode() ? ThemeMode.light : ThemeMode.dark,
    );

    await _saveChange();
  }

  Future<bool> _isDarkMode() async {
    final ThemeMode theme = await future;
    return theme == ThemeMode.dark;
  }

  Future<void> _saveChange() async {
    final localStorage = ref.read(localStorageProvider);
    final isDark = await _isDarkMode();
    await localStorage.write(key: 'isDarkMode', value: isDark.toString());
  }

  Future<ThemeMode> _readTheme() async {
    final localStorage = ref.read(localStorageProvider);
    final bool isDark = bool.parse(
      await localStorage.read(key: 'isDarkMode') ?? "false",
    );
    if (isDark) return ThemeMode.dark;
    return ThemeMode.light;
  }
}
