// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/Details.dart';
import '../services/httpService.dart';

class AcadDataController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Details studentData;
  // final academiaDataKey = const ObjectKey(Details);
  late AnimationController animationController;
  HttpService dhttp = HttpService();
  var tabIndex = 0.obs;
  var checkConnection = true.obs;
  late GetStorage box;
  var bottomNavColor = Colors.blue.shade100.obs;

  late String EMAIL = box.read('email');
  late String PASSWORD = box.read('password');

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 0) {
      bottomNavColor.value = Colors.blue.shade100;
    }
    if (index == 1) {
      bottomNavColor.value = const Color(0xff30307E);
    }
    if (index == 2) {
      bottomNavColor.value = Colors.blue.shade100;
    }
  }

  @override
  void onInit() {
    super.onInit();
    box = GetStorage('login');
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2500,
      ),
    );
  }

  Future<Details> getData() async {
    debugPrint('fetchAlbum called');

    final response = await dhttp.getRequest(endPoint: 'getDetails', query: {
      'email': EMAIL,
      'password': PASSWORD,
    });

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
}
