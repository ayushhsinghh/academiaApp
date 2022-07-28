import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Views/HomePage/HomePage.dart';
import 'Views/HomePage/binding.dart';
import 'Views/Profile/Components/Announcement.dart';
import 'Views/Profile/Components/UnifiedTT1.dart';
import 'Views/Profile/Components/UnifiedTT2.dart';
import 'Views/Undermaintenance.dart';
import 'Views/Login/Binding.dart';
import 'Views/Login/LoginPage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'envFiles/secret.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await GetStorage.init('login');

  runApp(MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  bool islogedIn = false;
  final box = GetStorage('login');

  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 10), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds:
              10), // fetch parameters will be cached for a maximum of 1 hour
    ));
    var defaultValue = {};
    await _remoteConfig.setDefaults({
      "ShowApp": true,
      'maintenanceDisplay': "Under Maintenance",
      'AppLink': "No Link Available",
      'announcement': json.encode(defaultValue)
    });

    _fetchConfig();
  }

  bool _checkLogin() {
    // box.remove("email");
    // box.remove("password");
    if (box.read('email') != null &&
        box.read('password') != null &&
        box.read('email') != '' &&
        box.read('password') != '') {
      return true;
    }
    return false;
  }

  // Fetching, caching, and activating remote config
  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();

    box.write("AppLink", _remoteConfig.getString('AppLink'));
    box.write("announcement", _remoteConfig.getString('announcement'));
  }

  @override
  void initState() {
    _initConfig();
    islogedIn = _checkLogin();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool showApp = _remoteConfig.getBool('ShowApp');
    return GetMaterialApp(
      title: 'SRM Academia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute:
          showApp ? (islogedIn ? '/home' : '/login') : '/undermaintenance',
      defaultTransition: Transition.size,
      getPages: [
        GetPage(
            name: '/login', page: () => LoginPage(), binding: LoginBinding()),
        GetPage(
          name: '/home',
          page: () => const HomePage(
            title: 'Academia',
          ),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/undermaintenance',
          page: () => UnderMaintenance(
            message: _remoteConfig.getString('maintenanceDisplay'),
          ),
        ),
        GetPage(name: '/announcements', page: () => const Announcement()),
        GetPage(name: '/UnifiedTT1', page: () => const UnifiedTT1()),
        GetPage(name: '/UnifiedTT2', page: () => const UnifiedTT2()),
      ],
    );
  }
}
