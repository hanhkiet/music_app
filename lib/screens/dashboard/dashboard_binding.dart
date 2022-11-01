import 'package:get/get.dart';
import 'package:music_app/screens/dashboard/dashboard_controller.dart';
import 'package:music_app/screens/home/home_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => HomeController());
  }
}
