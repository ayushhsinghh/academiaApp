import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../Controllers/AcadControllers.dart';
import '../../../models/Details.dart';
import '../../Attendance/AttendanceContainer.dart';

AttendanceBuilder(Details snapshot) {
  // final controller = Get.find<AcadDataController>();
  return GetBuilder<AcadDataController>(
      builder: (controller) => RefreshIndicator(
            // edgeOffset: 5.0,
            onRefresh: () async {
              snapshot = await controller.getData();
              return;
            },
            child: snapshot.attendance!.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/json/no-data-found.json',
                          repeat: true,
                        ),
                        const Text(
                          "No Data Available",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: snapshot.attendance!.length,
                    itemBuilder: (context, index) {
                      return AttendanceContainer(
                        studentInfo: (snapshot),
                        index: index,
                      );
                    }),
          ));
}
