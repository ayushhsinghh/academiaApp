import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

MonthViewSettings monthView() {
  return const MonthViewSettings(
      showAgenda: true,
      dayFormat: 'EEE',
      appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
      agendaStyle: AgendaStyle(
          backgroundColor: Color(0xFF066cccc),
          appointmentTextStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(239, 255, 255, 255))),
      monthCellStyle: MonthCellStyle(
          backgroundColor: Color.fromARGB(255, 151, 169, 242),
          trailingDatesBackgroundColor: Color.fromARGB(255, 142, 196, 219),
          leadingDatesBackgroundColor: Color.fromARGB(255, 142, 196, 219),
          todayBackgroundColor: Color.fromARGB(255, 151, 169, 149),
          textStyle: TextStyle(
            fontSize: 15,
            fontFamily: 'Arial',
          ),
          trailingDatesTextStyle: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 12, fontFamily: 'Arial'),
          leadingDatesTextStyle: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 12, fontFamily: 'Arial')));
}
