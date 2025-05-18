import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:info_a1/core/injection.dart';
import 'package:info_a1/core/util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';
import 'core/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://mnpxjsopinyzmgfdxkfo.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ucHhqc29waW55em1nZmR4a2ZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY5NzMwNjYsImV4cCI6MjA2MjU0OTA2Nn0.BUgcBcjhLqqHv9v0C_U7QMImT_XPH7oKJG-OVh-BpnI",
  );
  Injection.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Bebas Neue");

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
    );
  }
}
