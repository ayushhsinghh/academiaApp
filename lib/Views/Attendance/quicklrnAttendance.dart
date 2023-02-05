import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../Controllers/AcadControllers.dart';
import '../../models/quicklrn.dart';
import '../HomePage/Components/ShimmerEffect.dart';
import 'quicklrnContainer.dart';

class QuicklrnAttendace extends StatefulWidget {
  QuicklrnAttendace({Key? key}) : super(key: key);

  @override
  State<QuicklrnAttendace> createState() => _QuicklrnAttendaceState();
}

class _QuicklrnAttendaceState extends State<QuicklrnAttendace> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AcadDataController>();
    final box = GetStorage('login');
    return Center(
        child: FutureBuilder<QuicklrnApi>(
      future: controller.getquicklrn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AttendanceBuilder(snapshot.data!);
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
                          box.remove('qpassword');
                          Get.offAllNamed('/home');
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
                    color: Colors.black,
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
                          box.remove('qpassword');
                          Get.offAllNamed('/home');
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
                          box.remove('qpassword');
                          Get.offAllNamed('/home');
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
        return shimmerEffectAttandance(context);
      },
    ));
  }

  Widget AttendanceBuilder(QuicklrnApi snapshot) {
    // final controller = Get.find<AcadDataController>();
    return GetBuilder<AcadDataController>(
        builder: (controller) => RefreshIndicator(
              // edgeOffset: 5.0,
              onRefresh: () async {
                snapshot = await controller.getquicklrn();
                return;
              },
              child: snapshot.attendance.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/json/no-data-found.json',
                            repeat: true,
                          ),
                          const Text(
                            "No Data Available",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: ScrollController(),
                      itemCount: snapshot.attendance.length,
                      itemBuilder: (context, index) {
                        return QuicklrnAttendanceContainer(
                          studentInfo: (snapshot),
                          index: index,
                        );
                      }),
            ));
  }
}
