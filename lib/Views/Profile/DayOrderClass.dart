import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srmacademia/models/Calender.dart';

import '../../Controllers/AcadControllers.dart';

class DayOrder extends StatelessWidget {
  DayOrder({Key? key}) : super(key: key);

  final controller = Get.put(AcadDataController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Calender>(
        future: controller.getCalender(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String dayOrder = snapshot.data!.dayOrder;
            return Text(
              "Day Order: $dayOrder",
              style: const TextStyle(
                fontSize: 15.0,
              ),
            );
          }
          if (snapshot.hasError) {
            return const Text(
              "Day Order: Not Available",
              style: TextStyle(
                fontSize: 15.0,
              ),
            );
          }
          return SizedBox(
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.white,
              child: Text(
                'Day Order: Fetching Data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          );
        });
  }
}
