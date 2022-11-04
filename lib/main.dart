import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:music_app/screens/dashboard/dashboard.dart';
import 'package:music_app/screens/dashboard/dashboard_binding.dart';
import 'package:music_app/screens/song/song_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // ThemeData appTheme = AppTheme(isDark: true).toThemeData();
    Get.put(PlayerController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      initialRoute: '/dashboard',
      getPages: [
        GetPage(
          name: '/dashboard',
          page: () => const DashBoard(),
          binding: DashBoardBinding(),
        ),
        GetPage(
          name: '/song',
          page: () => const SongScreen(),
        ),
      ],
    );
  }
}
