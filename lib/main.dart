import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app/themes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppTheme(isDark: true).toThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: appTheme,
      home: null,
    );
  }
}
