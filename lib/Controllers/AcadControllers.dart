// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:srmacademia/models/Calender.dart';

import '../models/Details.dart';
import '../models/quicklrn.dart';
import '../services/httpService.dart';

class AcadDataController extends GetxController {
  late Details studentData;
  late Calender calender;
  late QuicklrnApi quicklrn;
  late TextEditingController qpasswordController;
  final PageController _pageController = PageController();
  // final academiaDataKey = const ObjectKey(Details);

  @override
  void onInit() {
    super.onInit();
    box = GetStorage('login');
    qpasswordController = TextEditingController();
  }

  @override
  void onClose() {
    qpasswordController.dispose();
  }

  HttpService dhttp = HttpService();
  var tabIndex = 0.obs;
  var checkConnection = true.obs;
  late GetStorage box;
  var bottomNavColor = Colors.blue.shade100.obs;

  late String EMAIL = box.read('email');
  late String PASSWORD = box.read('password');
  late String qPASSWORD = box.read('qpassword');

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 0) {
      bottomNavColor.value = Colors.blue.shade100;
    }
    if (index == 1) {
      bottomNavColor.value = const Color(0xff30307E);
    }
    if (index == 2) {
      bottomNavColor.value = const Color(0xff066cccc);
    }
    if (index == 3) {
      bottomNavColor.value = Colors.blue.shade100;
    }
  }

  Future<Details> getData() async {
    debugPrint('fetchAlbum called');

    final response = await dhttp.getRequest(
        endPoint: 'getDetails',
        query: {
          'email': EMAIL,
          'password': PASSWORD,
        },
        maxage: 1,
        maxStale: 60);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      studentData = detailsFromJson(response.toString());
      // debugPrint('id: ${studentData.id} title: ${newAlbum.title}');

      return studentData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Academia Data');
    }
  }

  Future<Calender> getCalender() async {
    debugPrint('GetCalender called');
    // Future.delayed(const Duration(seconds: 20), () {
    //   print("waiting for calender");
    // });

    final response = await dhttp.getRequest(
        endPoint: 'getCal',
        query: {
          'email': EMAIL,
          'password': PASSWORD,
        },
        maxage: 240,
        maxStale: 1440);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      calender = calenderFromJson(response.toString());
      // debugPrint('id: ${studentData.id} title: ${newAlbum.title}');
      // print(calender.calEven);

      return calender;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Calender Data');
    }
  }

  Future<QuicklrnApi> getquicklrn() async {
    debugPrint('quicklrn API called');
    // Future.delayed(const Duration(seconds: 20), () {
    //   print("waiting for calender");
    // });

    final response = await dhttp.getRequest(
        endPoint: 'getquicklrn',
        query: {
          'email': EMAIL,
          'password': qPASSWORD,
        },
        maxage: 1,
        maxStale: 60);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      quicklrn = quicklrnApiFromJson(response.toString());
      // debugPrint('id: ${studentData.id} title: ${newAlbum.title}');
      // print(calender.calEven);

      return quicklrn;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load quicklrn Data');
    }
  }
}
