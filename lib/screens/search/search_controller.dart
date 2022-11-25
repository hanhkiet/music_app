import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchFieldController = TextEditingController();
  final showResult = false.obs;

  updateShowResult(bool state) => showResult(state);
}
