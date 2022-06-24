import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'Views/Attendance/AttedancePage.dart';
import 'Views/Attendance/Binding.dart';
import 'Views/Login/Binding.dart';
import 'Views/Login/LoginPage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'envFiles/secret.env');
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

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
      navigatorKey: navigatorKey,
      initialRoute: '/login',
      defaultTransition: Transition.zoom,
      getPages: [
        GetPage(
            name: '/login',
            page: () => const LoginPage(),
            binding: LoginBinding()),
        GetPage(
          name: '/attendance',
          page: () => const AttendancePage(
            title: 'Academia',
          ),
          binding: AttendanceBinding(),
        ),
      ],
    );
  }
}
