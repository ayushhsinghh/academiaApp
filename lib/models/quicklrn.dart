import 'dart:convert';

QuicklrnApi quicklrnApiFromJson(String str) =>
    QuicklrnApi.fromJson(json.decode(str));

String quicklrnApiToJson(QuicklrnApi data) => json.encode(data.toJson());

class QuicklrnApi {
  QuicklrnApi({
    required this.attendance,
    required this.marks,
    required this.timetable,
  });

  final List<List<dynamic>> attendance;
  final List<List<dynamic>> marks;
  Map<String, List<Timetable>> timetable;

  factory QuicklrnApi.fromJson(Map<String, dynamic> json) => QuicklrnApi(
        attendance: List<List<dynamic>>.from(
            json["attendance"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        marks: List<List<dynamic>>.from(
            json["marks"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        timetable: Map.from(json["timetable"]).map((k, v) =>
            MapEntry<String, List<Timetable>>(
                k, List<Timetable>.from(v.map((x) => Timetable.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "attendance": List<dynamic>.from(
            attendance.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "marks": List<dynamic>.from(
            marks.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "timetable": Map.from(timetable).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class Timetable {
  Timetable({
    required this.attendanceTime,
    required this.attendanceTopic,
    required this.date,
    required this.time,
    required this.courseName,
    this.attendanceId,
    required this.url,
    required this.dayOrder,
    this.dayOrderInfo,
    this.sessionSlotEndTime,
    this.attendanceStartTime,
  });

  DateTime attendanceTime;
  String attendanceTopic;
  DateTime date;
  String time;
  String courseName;
  int? attendanceId;
  String url;
  int dayOrder;
  String? dayOrderInfo;
  DateTime? sessionSlotEndTime;
  dynamic attendanceStartTime;

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        attendanceTime: DateTime.parse(json["attendance_time"]),
        attendanceTopic: json["attendance_topic"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        courseName: json["course_name"],
        attendanceId: json["attendance_id"],
        url: json["url"],
        dayOrder: json["day_order"],
        dayOrderInfo: json["day_order_info"],
        sessionSlotEndTime: json["session_slot_end_time"] == null
            ? null
            : DateTime.parse(json["session_slot_end_time"]),
        attendanceStartTime: json["attendance_start_time"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_time": attendanceTime.toIso8601String(),
        "attendance_topic": attendanceTopic,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "course_name": courseName,
        "attendance_id": attendanceId,
        "url": url,
        "day_order": dayOrder,
        "day_order_info": dayOrderInfo,
        "session_slot_end_time": sessionSlotEndTime?.toIso8601String(),
        "attendance_start_time": attendanceStartTime,
      };
}
