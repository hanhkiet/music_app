import 'package:get/get.dart';
import 'package:music_app/screens/artist/artist_screen.dart';
import 'package:music_app/screens/collection/collection_screen.dart';
import 'package:music_app/screens/sign/sign_binding.dart';
import 'package:music_app/screens/sign/sign_screen.dart';
import 'package:music_app/screens/song/song_screen.dart';

import 'screens/dashboard/dashboard.dart';
import 'screens/dashboard/dashboard_binding.dart';

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
    name: '/sign',
    page: () => const SignScreen(),
    binding: SignBinding(),
  ),
];
