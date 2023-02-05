import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:srmacademia/Views/Profile/DayOrderClass.dart';
import 'package:srmacademia/main.dart';
import 'package:srmacademia/models/quicklrn.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../models/Details.dart';
import 'Components/DataSource.dart';
import 'Components/MonthView.dart';
import 'Components/ShowDialog.dart';

class QuicklrnCalender extends StatelessWidget {
  const QuicklrnCalender({Key? key, required this.studentInfo})
      : super(key: key);

  final QuicklrnApi studentInfo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: const Color(0xff30307E),
          body: SfCalendar(
        view: CalendarView.month,

        showNavigationArrow: true,
        minDate: DateTime.now().subtract(const Duration(days: 120)),
        maxDate: DateTime.now().add(const Duration(days: 120)),
        timeZone: 'India Standard Time',
        initialSelectedDate: DateTime.now(),
        onTap: showDialogforMoreInfo,
        headerStyle: const CalendarHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Color(0xff066cccc),
            textStyle: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.normal,
                letterSpacing: 5,
                color: Color(0xFFff5eaea),
                fontWeight: FontWeight.w500)),
        todayTextStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Arial'),
        dataSource: MeetingDataSource(_getDataSource()),
        monthViewSettings: monthView(),

        // dataSource: MeetingDataSource(getCalendarData(studentInfo)),
      )),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    Map<String, List<Timetable>> timetable = studentInfo.timetable;

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
}
