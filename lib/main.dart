import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/providers/core/services/theme_provider.dart';
import 'package:udb_news/views/screens/splash_screen.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeProvider = ref.watch(themeToggleProvider);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pink,
        secondaryHeaderColor: Colors.blue.shade900,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.pink,
        secondaryHeaderColor: Colors.blue.shade500,
      ),
      themeMode: themeModeProvider.when(
        data: (theme) => theme,
        error: (_, _) => ThemeMode.light,
        loading: () => ThemeMode.light,
      ),
      home: SplashScreen(),
    );
  }
}
