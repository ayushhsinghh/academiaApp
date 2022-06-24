// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:srmacadmia/models/Details.dart';

import '../services/httpService.dart';

class AcadDataController extends GetxController {
  late Details studentData;
  HttpService dhttp = HttpService();
  var tabIndex = 0;

  String EMAIL = dotenv.env['EMAIL']!;
  String PASSWORD = dotenv.env['PASSWORD']!;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
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
      throw Exception('Failed to load album');
    }
  }
}
