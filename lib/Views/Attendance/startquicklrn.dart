import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:srmacademia/Controllers/LoginController.dart';
import 'package:srmacademia/Views/Attendance/quicklrnAttendance.dart';

import '../../Controllers/AcadControllers.dart';
import '../../models/quicklrn.dart';
import 'Components/backgroud.dart';

class StartQuicklrn extends StatelessWidget {
  const StartQuicklrn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final box = GetStorage('login');
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Connect Quicklrn for Attendance",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Enter Password",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) => controller.qpassword = value,
                decoration: const InputDecoration(
                  hintText: "Enter your Quicklrn Password",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shadowColor: Colors.blue.shade700,

                elevation: 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),

                backgroundColor: Colors.blue.shade700,
              ),
              onPressed: () {
                if (controller.qpassword.isEmpty) {
                  Get.snackbar('Error', 'Enter quicklrn password',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.shade700,
                      colorText: Colors.white,
                      borderRadius: 10,
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 2));
                } else {
                  if (controller.qpassword.length < 6) {
                    Get.snackbar(
                        'Error', 'Password should be atleast 8 characters',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade700,
                        colorText: Colors.white,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(10),
                        duration: const Duration(seconds: 2));
                  } else {
                    box.write("qpassword", controller.qpassword);
                    Get.snackbar('Success', 'Password saved on device',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.shade700,
                        colorText: Colors.white,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(10),
                        duration: const Duration(seconds: 1));
                    Get.offAllNamed("/home");
                  }
                }
              },
              child: const Text("Connect"),
            ),
          ],
        ),
      ),
    );
  }
}
