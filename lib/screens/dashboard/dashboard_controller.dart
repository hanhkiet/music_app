import 'package:get/state_manager.dart';

class DashBoardController extends GetxController {
  var tabIndex = 1;

  changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
