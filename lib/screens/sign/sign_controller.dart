import 'package:get/get.dart';

class SignController extends GetxController {
  final screen = Screen.signin.obs;

  updateScreenEnum(screen) {
    this.screen(screen);
  }
}

enum Screen {
  signin,
  signup,
}
