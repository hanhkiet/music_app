import 'package:get/state_manager.dart';

class DashBoardController extends GetxController {
  var tabIndex = 3;

  changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
