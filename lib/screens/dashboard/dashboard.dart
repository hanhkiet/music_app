import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/dashboard/dashboard_controller.dart';
import 'package:music_app/screens/home/home_screen.dart';
import 'package:music_app/screens/search/search_screen.dart';
import 'package:music_app/screens/user/user_screen.dart';
import 'package:music_app/themes.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            IndexedStack(
              index: controller.tabIndex,
              children: [
                const HomeScreen(),
                const SearchScreen(),
                Container(),
                const UserScreen(),
              ],
            ),
            // const MinimizePlayer(height: 60),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.accent,
          unselectedItemColor: Colors.white.withOpacity(.7),
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play_rounded),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'User',
            ),
          ],
        ),
      );
    });
  }
}
