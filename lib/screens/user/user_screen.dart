import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_app/screens/user/user_controller.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Center(
          child: Text('user'),
        ),
      ),
    );
  }
}
