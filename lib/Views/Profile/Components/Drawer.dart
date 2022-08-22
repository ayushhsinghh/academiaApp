import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../DayOrderClass.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.userInfo}) : super(key: key);

  final Map<String, dynamic> userInfo;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage('login');
    String link = box.read('AppLink') ?? 'No Link Available';

    return Drawer(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(20)),
      ),
      backgroundColor: Colors.blue.shade100,
      child: ListView(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.red.shade100,
                      ),
                      child: Lottie.asset(
                        'assets/json/humans.json',
                        repeat: true,
                      )
                      // Text(
                      //   userInfo['Name:'].substring(0, 1),
                      //   style: const TextStyle(
                      //     fontSize: 40,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.userSecret,
                        color: Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        // overflow: TextOverflow.clip,
                        // maxLines: 2,
                        userInfo['Name:'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.bookOpenReader,
                        color: Colors.black,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userInfo['Program:'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.idCard,
                        color: Colors.black,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userInfo['Registration Number:'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.graduationCap,
                        color: Colors.black,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userInfo['Department:'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.calendarDay,
                        color: Colors.black,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      DayOrder()
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            indent: 15,
            endIndent: 15,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          ListTile(
            iconColor: Colors.black,
            leading: const Icon(FontAwesomeIcons.scroll),
            title: const Text('Announcements'),
            onTap: () => Get.toNamed('/announcements'),
          ),
          ListTile(
              iconColor: Colors.black,
              leading: const Icon(FontAwesomeIcons.calendar),
              title: const Text('Academic Calender'),
              onTap: () => Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.blue.shade100,
                      title: const Text('Academic Calender'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {
                                      Get.toNamed('/calenderEven');
                                    },
                                    child: const Text(
                                        "Academic Planner Even Sem.")),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {
                                      Get.toNamed('/calenderOdd');
                                    },
                                    child: const Text(
                                        "Academic Planner Odd Sem.")),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
          ListTile(
            iconColor: Colors.black,
            leading: const Icon(FontAwesomeIcons.table),
            title: const Text('Unified Time Table'),
            onTap: () => Get.dialog(
              AlertDialog(
                backgroundColor: Colors.blue.shade100,
                title: const Text('Unified Time Table'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed('/UnifiedTT1');
                              },
                              child: const Text("Batch 1")),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed('/UnifiedTT2');
                              },
                              child: const Text("Batch 2")),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            iconColor: Colors.black,
            leading: const Icon(FontAwesomeIcons.calculator),
            title: const Text('Attendance Calculator'),
            onTap: () => Get.toNamed('/Calculator'),
          ),
          ListTile(
              iconColor: Colors.black,
              leading: const Icon(FontAwesomeIcons.download),
              title: const Text('Check for Updates...'),
              onTap: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                String version = packageInfo.version;
                Get.dialog(
                  AlertDialog(
                    backgroundColor: Colors.blue.shade100,
                    title: const Text('Download APK (Selectable)'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade200,
                          ),
                          child: SelectableText(
                            link,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            // color: Colors.blue.shade200,
                          ),
                          child: Text(
                            'Current Version: $version',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                );
              }),
          ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            iconColor: Colors.black,
            leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            title: const Text('Logout'),
            onTap: () => Get.dialog(
              AlertDialog(
                backgroundColor: Colors.blue.shade100,
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      box.remove('email');
                      box.remove('password');

                      Get.offAllNamed('/login');
                    },
                  ),
                  TextButton(
                    child: const Text('No'),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
