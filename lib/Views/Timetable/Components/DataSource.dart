import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../models/quicklrn.dart';

List<Meeting> _getDataSource(Map<String, List<Timetable>> timetable1) {
  final List<Meeting> meetings = <Meeting>[];
  Map<String, List<Timetable>> timetable = timetable1;

  timetable.forEach((key, value) {
    for (var element in value) {
      DateTime startTime = DateTime.parse("$key ${element.time}");
      if (element.sessionSlotEndTime == null) {
        meetings.add(Meeting(
            element.attendanceTopic,
            startTime,
            startTime.add(const Duration(hours: 2)),
            const Color.fromARGB(255, 209, 51, 51),
            element.courseName,
            true,
            0));
        continue;
      }
      DateTime? endTime = element.sessionSlotEndTime;
      meetings.add(Meeting(
          element.courseName,
          startTime,
          endTime!,
          const Color(0xFF0F8644),
          element.attendanceTopic,
          false,
          element.dayOrder));
    }
  });
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  String getNotes(int index) {
    return appointments![index].notes;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  int getDayOrder(int index) {
    return appointments![index].dayOrder;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.notes,
      this.isAllDay, this.dayOrder);

  String eventName;
  String notes;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  int dayOrder;
}
