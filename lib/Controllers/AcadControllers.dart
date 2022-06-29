// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:srmacadmia/models/Details.dart';

import '../services/httpService.dart';

class AcadDataController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Details studentData;
  // final academiaDataKey = const ObjectKey(Details);
  late AnimationController animationController;
  HttpService dhttp = HttpService();
  var tabIndex = 0.obs;
  var checkConnection = true.obs;

  String EMAIL = dotenv.env['EMAIL']!;
  String PASSWORD = dotenv.env['PASSWORD']!;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
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
