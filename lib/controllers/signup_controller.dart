import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // TextEditingControllers for TextFormFields
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Reactive validation flags
  final isUsernameValid = true.obs;
  final isEmailValid = true.obs;
  final isPhoneValid = true.obs;
  final isPasswordValid = true.obs;
  var isLoading = false.obs;

  // Validation logic
  void validateUsername(String username) {
    isUsernameValid.value = username.isNotEmpty && username.length >= 3;
  }

  void validateEmail(String email) {
    isEmailValid.value = GetUtils.isEmail(email);
  }

  void validatePhone(String phone) {
    isPhoneValid.value = phone.isNotEmpty && phone.length == 10;
  }

  void validatePassword(String password) {
    isPasswordValid.value = password.isNotEmpty && password.length >= 6;
  }

// Avoid manually disposing of TextEditingControllers here;
// GetX will handle disposal when the controller is removed from memory.
}
