import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController,
      passwordController,
      qpasswordController;
  var email = '';
  var password = '';
  var qpassword = '';
  final isvisible = true.obs;

  void changevisibilty() {
    isvisible.value = !isvisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    qpasswordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    qpasswordController.dispose();
  }

  bool validateEmail() {
    if (GetUtils.isEmail(emailController.text)) {
      return false;
    }

    return true;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
  }
}
