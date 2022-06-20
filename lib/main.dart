import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:srmacadmia/Pages/AttendanceContainer.dart';
import 'package:srmacadmia/models/Details.dart';

import 'Controllers/Controllers.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'envFiles/secret.env');

  Get.put(AcadDataController());
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
      home: const MyHomePage(title: 'SRM Academia'),
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
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
