import 'package:get/get.dart';
import 'package:music_app/screens/dashboard/dashboard_controller.dart';
import 'package:music_app/screens/home/home_controller.dart';
import 'package:music_app/screens/sign_in/sign_in_controller.dart';
import 'package:music_app/screens/user/user_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => SignInController());
  }
}
