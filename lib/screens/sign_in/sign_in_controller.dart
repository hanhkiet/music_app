import 'package:get/get.dart';

class SignInController extends GetxController {
  final hasError = false.obs;
  String message = '';

  updateError(bool hasError, {String message = ''}) {
    this.hasError(hasError);
    this.message = message;
  }
}
