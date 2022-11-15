import 'package:get/get.dart';
import 'package:music_app/screens/sign/sign_controller.dart';
import 'package:music_app/screens/sign/sign_in/sign_in_controller.dart';
import 'package:music_app/screens/sign/sign_up/sign_up_controller.dart';

class SignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignController());
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
  }
}
