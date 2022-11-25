import 'package:get/get.dart';

class SearchController extends GetxController {
  final query = ''.obs;

  String get getQuery => query.value;

  updateQuery(String newQuery) => query(newQuery);
}
