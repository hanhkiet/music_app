import 'package:get/get.dart';

import 'screens/dashboard/dashboard.dart';
import 'screens/dashboard/dashboard_binding.dart';
import 'screens/song/song_screen.dart';

final routes = [
  GetPage(
    name: '/dashboard',
    page: () => const DashBoard(),
    binding: DashBoardBinding(),
  ),
  GetPage(
    name: '/song',
    page: () => const SongScreen(),
  ),
];
