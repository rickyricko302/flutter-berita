import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/core/services/theme_provider.dart';

class ThemeButton extends ConsumerWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeToggleProvider);
    final themeModeNotifier = ref.read(themeToggleProvider.notifier);
    return IconButton(
      iconSize: 32,
      style: IconButton.styleFrom(
        backgroundColor: Colors.black,
        side: BorderSide(color: Colors.white.withValues(alpha: .2)),
      ),
      onPressed: () {
        themeModeNotifier.toggleTheme();
      },
      icon: themeMode.when(
        data:
            (theme) =>
                theme == ThemeMode.dark
                    ? Icon(Icons.light_mode, color: Colors.white)
                    : Icon(Icons.dark_mode, color: Colors.white),
        error: (_, _) => Icon(Icons.dark_mode, color: Colors.white),
        loading: () => Icon(Icons.light_mode, color: Colors.white),
      ),
    );
  }
}
