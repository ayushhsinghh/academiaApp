import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:srmacademia/Views/Timetable/NoData.dart';
import 'package:srmacademia/Views/Undermaintenance.dart';

import '../../Controllers/AcadControllers.dart';
import '../../models/Details.dart';
import '../Attendance/quicklrnAttendance.dart';
import '../Marks/quicklrnMarksBuilder.dart';
import '../Timetable/TimetableCalender.dart';
import 'Components/AttendanceBuilder.dart';
import 'Components/BottomNavBar.dart';
import 'Components/MarksBuilder.dart';
import 'Components/ProfileBuilder.dart';
import 'Components/ShimmerEffect.dart';
import '../Attendance/startquicklrn.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  static const id = 'MyHomePage';
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AcadDataController>();
    if (kDebugMode) {
      print("hello");
    }
    final box = GetStorage('login');
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: FutureBuilder<Details>(
          future: controller
              .getData(), // this now lives it its own AcadDataController class
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              box.read('qpassword') != null ? controller.getData() : null;
              controller.checkConnection.value = true;
              controller.getCalender();
              // print("futureCalled");
              return Obx(() => IndexedStack(
                    index: controller.tabIndex.value,
                    children: [
                      AttendanceBuilder(snapshot.requireData),
                      MarksBuilder(snapshot),
                      // box.read('qpassword') != null
                      //     ? QuicklrnAttendace()
                      //     : StartQuicklrn(),
                      // box.read('qpassword') != null
                      //     ? QuicklrnMarksBuilder()
                      //     : StartQuicklrn(),
                      // NoData(),
                      const UnderMaintenance2(message: "Under Maintenance"),
                      ProfileBuilder(snapshot),
                    ],
                  ));
            } else if (snapshot.hasError) {
              // Catch Socket Errors
              controller.checkConnection.value = false;
              if (snapshot.error.toString().contains('SocketException')) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/json/no-internet.json',
                      repeat: true,
                    ),
                    const Text(
                      'No Internet Connection',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              box.remove('email');
                              box.remove('password');

                              Get.offAllNamed('/login');
                            },
                            child: const Text("Login Again")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed('/home');
                            },
                            child: const Text("Reload")),
                      ],
                    )
                  ],
                );
              } else if (snapshot.error.toString().contains('error [500]')) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/json/Wrongpassword.json',
                      repeat: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      '403 : Wrong Credentials',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              box.remove('email');
                              box.remove('password');

                              Get.offAllNamed('/login');
                            },
                            child: const Text("Login Again")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed('/home');
                            },
                            child: const Text("Reload")),
                      ],
                    )
                  ],
                );
              } else if (snapshot.error.toString().contains('error [422]')) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/json/character-animation.json',
                      repeat: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      '422 : unable to process the contained instructions',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              box.remove('email');
                              box.remove('password');

                              Get.offAllNamed('/login');
                            },
                            child: const Text("Login Again")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed('/home');
                            },
                            child: const Text("Reload")),
                      ],
                    )
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lottie.asset("assets/json/character-animation.json"),
                    Lottie.asset("assets/json/404Error.json"),
                    // Lottie.asset("assets/json/login.json"),
                    Text("${snapshot.error}"),
                  ],
                );
              }
            }
            // By default, show a loading spinner.
            return shimmerEffectAttandance(context);
          },
        ),
      ),
      bottomNavigationBar: controller.checkConnection.value
          ? Obx(() => BottomNavBar(controller))
          : null,
    );
  }
}
