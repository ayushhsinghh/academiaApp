import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:srmacadmia/Views/Attendance/AttendanceContainer.dart';
import 'package:srmacadmia/models/Details.dart';

import 'Controllers/Controllers.dart';
import 'Views/Attendance/Binding.dart';
import 'Views/Login/Binding.dart';
import 'Views/Login/LoginPage.dart';

import 'package:shimmer/shimmer.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'envFiles/secret.env');

  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      defaultTransition: Transition.zoom,
      getPages: [
        GetPage(
            name: '/login',
            page: () => const LoginPage(),
            binding: LoginBinding()),
        GetPage(
          name: '/attendance',
          page: () => const MyHomePage(
            title: 'Academia',
          ),
          binding: AttendanceBinding(),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  static const id = 'MyHomePage';
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AcadDataController>();
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: FutureBuilder<Details>(
          future: controller
              .getData(), // this now lives it its own AlbumController class
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.attendance!.length,
                  itemBuilder: (context, index) {
                    return AttendanceContainer(
                      studentInfo: (snapshot.data)!,
                      index: index,
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
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
          },
        ),
      ),
    );
  }
}
