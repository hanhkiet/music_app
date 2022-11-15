import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/sign/sign_controller.dart';
import 'package:music_app/screens/sign/sign_in/sign_in_section.dart';
import 'package:music_app/screens/sign/sign_up/sign_up_section.dart';
import 'package:music_app/widgets/background.dart';

class SignScreen extends GetView<SignController> {
  const SignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => controller.screen.value == Screen.signin
                ? SignInSection(updateScreen: controller.updateScreenEnum)
                : SignUpSection(updateScreen: controller.updateScreenEnum),
          ),
        ),
      ),
    );
  }
}
