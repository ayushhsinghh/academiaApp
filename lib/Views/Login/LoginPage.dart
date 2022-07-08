import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../Controllers/LoginController.dart';
import '../constants.dart';
import 'Components/BackgroudImage.dart';
import 'Components/EmailInput.dart';
import 'Components/PasswordInput.dart';
import 'Components/RoundedButton.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  final box = GetStorage('login');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: controller.loginFormKey,
                // autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: const Center(
                        child: Text(
                          'Login',
                          style: kHeading,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600]!.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(
                                          FontAwesomeIcons.solidEnvelope,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      hintStyle: kBodyText,
                                    ),
                                    onSaved: (value) {
                                      controller.email = value!;
                                    },
                                    onChanged: (value) {
                                      controller.email = value;
                                    },
                                    // validator: (value) {
                                    //   return controller.validateEmail(value!);
                                    // },
                                    controller: controller.emailController,
                                    style: kBodyText,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Obx(
                                  () => Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[600]!.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          suffix: InkWell(
                                            onTap: controller.changevisibilty,
                                            child: Icon(
                                              controller.isvisible.value
                                                  ? FontAwesomeIcons.eye
                                                  : FontAwesomeIcons.eyeSlash,
                                              color: Colors.white,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 20),
                                          border: InputBorder.none,
                                          // suffix:,
                                          hintText: 'Password',
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Icon(
                                              FontAwesomeIcons.lock,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          hintStyle: kBodyText,
                                        ),
                                        onSaved: (value) {
                                          controller.password = value!;
                                        },
                                        onChanged: (value) {
                                          controller.password = value;
                                        },
                                        controller:
                                            controller.passwordController,
                                        obscureText: controller.isvisible.value,
                                        style: kBodyText,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity / 0.6,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.white10,
                                      Colors.white38,
                                      Colors.white10,
                                      Colors.white38,
                                      Colors.transparent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (controller.validateEmail()) {
                                      print("check email");
                                      Get.snackbar(
                                          'Error', 'Wrong Email Format',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          borderRadius: 10,
                                          margin: const EdgeInsets.all(10),
                                          duration: const Duration(seconds: 2));
                                    } else if (controller.email != '' &&
                                        controller.password != '') {
                                      box.write("email", controller.email);
                                      box.write(
                                          "password", controller.password);
                                      print("Data Written");

                                      // box.remove("email");
                                      // box.remove("password");

                                      Get.offAllNamed('/attendance');
                                    } else {
                                      Get.snackbar(
                                          'Error', 'Please fill all the fields',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          borderRadius: 10,
                                          margin: const EdgeInsets.all(10),
                                          duration: const Duration(seconds: 2));
                                    }
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
