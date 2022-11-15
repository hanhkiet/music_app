import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();

  final isObscurePasswordField = true.obs;
  final isObscureReEnterPasswordField = true.obs;

  final hasError = false.obs;
  final message = ''.obs;

  String get emailText => emailController.value.text;
  String get passwordText => passwordController.value.text;
  String get reEnterPasswordText => reEnterPasswordController.value.text;

  updateErrorStatus(bool status, {String message = ''}) {
    hasError(status);
    this.message(message);
    update();
  }

  toggleObscurePasswordField() =>
      isObscurePasswordField(!isObscurePasswordField.value);

  toggleObscureReEnterPasswordField() =>
      isObscureReEnterPasswordField(!isObscureReEnterPasswordField.value);
}
