import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/archives/user_screen.dart';
import 'package:music_app/screens/dashboard/dashboard_controller.dart';
import 'package:music_app/screens/home/home_screen.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.red,
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              const HomeScreen(),
              UserScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 0, 171, 180),
          unselectedItemColor: Colors.white.withOpacity(.7),
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
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
