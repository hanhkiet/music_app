import 'package:get/get.dart';
import 'package:music_app/screens/artist/artist_screen.dart';
import 'package:music_app/screens/collection/collection_screen.dart';
import 'package:music_app/screens/sign_in/sign_in_screen.dart';

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
  GetPage(
    name: '/collection',
    page: () => const CollectionScreen(),
  ),
  GetPage(
    name: '/artist',
    page: () => const ArtistScreen(),
  ),
  GetPage(
    name: '/signin',
    page: () => const SignInScreen(),
  ),
];
