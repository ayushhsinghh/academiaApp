import 'dart:convert';

Calender calenderFromJson(String str) => Calender.fromJson(json.decode(str));

String calenderToJson(Calender data) => json.encode(data.toJson());

class Calender {
  Calender({
    required this.date,
    required this.dayOrder,
    required this.calEven,
    required this.calOdd,
  });

  final String date;
  final String dayOrder;
  final Map<String, List<List<dynamic>>> calEven;
  final Map<String, List<List<dynamic>>> calOdd;

  factory Calender.fromJson(Map<String, dynamic> json) => Calender(
        date: json["date"],
        dayOrder: json["dayOrder"],
        calEven: Map.from(json["CalEven"]).map((k, v) =>
            MapEntry<String, List<List<dynamic>>>(
                k,
                List<List<dynamic>>.from(
                    v.map((x) => List<dynamic>.from(x.map((x) => x)))))),
        calOdd: Map.from(json["CalOdd"]).map((k, v) =>
            MapEntry<String, List<List<dynamic>>>(
                k,
                List<List<dynamic>>.from(
                    v.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "dayOrder": dayOrder,
        "CalEven": Map.from(calEven).map((k, v) => MapEntry<String, dynamic>(
            k,
            List<dynamic>.from(
                v.map((x) => List<dynamic>.from(x.map((x) => x)))))),
        "CalOdd": Map.from(calOdd).map((k, v) => MapEntry<String, dynamic>(
            k,
            List<dynamic>.from(
                v.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      };
}
