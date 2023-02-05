import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void showDialogforMoreInfo(CalendarTapDetails details) {
  if (details.targetElement == CalendarElement.appointment) {
    // GET showdialog box
    Get.defaultDialog(
      title: "Details",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CourseName: ${details.appointments![0].eventName.toString()}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          Text(
            "StartTime: ${details.appointments![0].to.toString()}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "EndTime: ${details.appointments![0].from.toString()}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "DayOrder: ${details.appointments![0].dayOrder.toString()}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "MoreInfo: ${details.appointments![0].notes.toString()}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Close"))
      ],
    );
  }
}
