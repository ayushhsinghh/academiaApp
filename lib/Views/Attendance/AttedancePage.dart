import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srmacadmia/Views/Profile/ProfilePage.dart';

import '../../Controllers/AcadControllers.dart';
import '../../models/Details.dart';
import '../Marks/MarksContainer.dart';
import 'AttendanceContainer.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key, required this.title}) : super(key: key);
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
      // appBar: AppBar(
      //   title: const Text("Attendance"),
      //   centerTitle: true,
      // ),
      backgroundColor: Color(0xff202054),
      body: Center(
        child: FutureBuilder<Details>(
          future: controller
              .getData(), // this now lives it its own AcadDataController class
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              controller.checkConnection.value = true;
              // print("futureCalled");
              return Obx(() => IndexedStack(
                    index: controller.tabIndex.value,
                    children: [
                      AttendanceBuilder(snapshot.data!),
                      MarksBuilder(snapshot),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          box.remove('email');
                          box.remove('password');

                          Get.offAllNamed('/login');
                        },
                        child: const Text("Login Again"))
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
                      '403 : Wrong Creditentials',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          box.remove('email');
                          box.remove('password');

                          Get.offAllNamed('/login');
                        },
                        child: const Text("Login Again"))
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          box.remove('email');
                          box.remove('password');

                          Get.offAllNamed('/login');
                        },
                        child: const Text("Login Again"))
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
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.blue,
      //     // add shadow
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.blueAccent.withOpacity(0.5),
      //         spreadRadius: 5,
      //         blurRadius: 7,
      //         offset: Offset(0, 3), // changes position of shadow
      //       ),
      //     ],
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   width: 100,
      //   height: 50,
      //   child: TextButton(
      //     child: Shimmer.fromColors(
      //       baseColor: Colors.red.shade300,
      //       highlightColor: Colors.grey.shade100,
      //       child: const Text(
      //         'Login Again',
      //         style: TextStyle(
      //           color: Colors.white,
      //           // fontSize: 20,
      //         ),
      //       ),
      //     ),
      //     onPressed: () {
      //       Get.offAllNamed('/login');
      //     },
      //   ),
      // ),
      bottomNavigationBar: controller.checkConnection.value
          ? Obx(() => BottomNavyBar(
                selectedIndex: controller.tabIndex.value,
                showElevation: true, // use this to remove appBar's elevation
                onItemSelected: controller.changeTabIndex,
                items: [
                  BottomNavyBarItem(
                      icon: const Icon(Icons.menu_book),
                      title: const Text('Attendance'),
                      activeColor: Colors.green.shade400),
                  BottomNavyBarItem(
                      icon: const Icon(Icons.dataset),
                      title: const Text('Marks'),
                      activeColor: Colors.purpleAccent),
                  BottomNavyBarItem(
                      icon: const Icon(Icons.person),
                      title: const Text('Profile'),
                      activeColor: Colors.blue.shade600),
                ],
              ))
          : null,
    );
  }

  // BottomNavigationBar(
  //               unselectedItemColor: Colors.black,
  //               selectedItemColor: Colors.black,
  //               onTap: controller.changeTabIndex,
  //               currentIndex: controller.tabIndex.value,
  //               showSelectedLabels: true,
  //               showUnselectedLabels: false,
  //               enableFeedback: true,
  //               type: BottomNavigationBarType.fixed,
  //               backgroundColor: Colors.transparent,
  //               elevation: 0,
  //               items: const [
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.menu_book),
  //                   label: 'Attendance',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.dataset),
  //                   label: 'Marks',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.person),
  //                   label: 'Profile',
  //                 ),
  //               ],
  //             )

  SizedBox shimmerEffectAttandance(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                itemBuilder: (_, __) => Container(
                  margin: const EdgeInsets.all(7),
                  height: MediaQuery.of(context).size.height * 0.22,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 25.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 48.0,
                        height: 68.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                itemCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AttendanceBuilder(Details snapshot) {
    // final controller = Get.find<AcadDataController>();
    return GetBuilder<AcadDataController>(
        builder: (controller) => RefreshIndicator(
              // edgeOffset: 5.0,
              onRefresh: () async {
                snapshot = await controller.getData();
                return;
              },
              child: snapshot.attendance!.isEmpty
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
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: snapshot.attendance!.length,
                      itemBuilder: (context, index) {
                        return AttendanceContainer(
                          studentInfo: (snapshot),
                          index: index,
                        );
                      }),
            ));
  }

  MarksBuilder(AsyncSnapshot<Details> snapshot) {
    return snapshot.data!.marks!.isEmpty
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
            itemCount: snapshot.data!.marks!.length,
            itemBuilder: (context, index) {
              return MarksContainer(
                studentInfo: (snapshot.data)!,
                index: index,
              );
            });
  }

  ProfileBuilder(AsyncSnapshot<Details> snapshot) {
    return ProfilePage(
      studentInfo: snapshot.data!,
    );
  }
}
