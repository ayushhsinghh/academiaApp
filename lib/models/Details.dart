// To parse this JSON data, do
//
//     final details = detailsFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
    this.attendanceFieldName,
    this.attendance,
    this.userInfo,
    this.marks,
    this.subcodetoName,
  });

  final List<String>? attendanceFieldName;
  final Map<String, List<String>>? attendance;
  final Map<String, dynamic>? userInfo;
  final Map<String, List<String>>? marks;
  final SubcodetoName? subcodetoName;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        attendanceFieldName:
            List<String>.from(json["attendanceFieldName"].map((x) => x)),
        attendance: Map.from(json["attendance"]).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        userInfo: Map.from(json["userInfo"])
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        marks: Map.from(json["marks"]).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        subcodetoName: SubcodetoName.fromJson(json["SubcodetoName"]),
      );

  Map<String, dynamic> toJson() => {
        "attendanceFieldName":
            List<dynamic>.from(attendanceFieldName!.map((x) => x)),
        "attendance": Map.from(attendance!).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "userInfo": Map.from(userInfo!)
            .map((k, v) => MapEntry<String, dynamic>(k, v as String)),
        "marks": Map.from(marks!).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "SubcodetoName": subcodetoName!.toJson(),
      };
}

class SubcodetoName {
  SubcodetoName({
    required this.the18Csc303J,
    required this.the18Lem110L,
    required this.the18Cse354T,
    required this.the18Csc304J,
    required this.the18Cse386T,
    required this.the18Csc350T,
    required this.the18Pdh201T,
    required this.the18Csc305J,
    required this.the18Ceo406T,
    required this.the18Csp104L,
    required this.the18Csc307L,
  });

  final String the18Csc303J;
  final String the18Lem110L;
  final String the18Cse354T;
  final String the18Csc304J;
  final String the18Cse386T;
  final String the18Csc350T;
  final String the18Pdh201T;
  final String the18Csc305J;
  final String the18Ceo406T;
  final String the18Csp104L;
  final String the18Csc307L;

  factory SubcodetoName.fromJson(Map<String, dynamic> json) => SubcodetoName(
        the18Csc303J: json["18CSC303J"],
        the18Lem110L: json["18LEM110L"],
        the18Cse354T: json["18CSE354T"],
        the18Csc304J: json["18CSC304J"],
        the18Cse386T: json["18CSE386T"],
        the18Csc350T: json["18CSC350T"],
        the18Pdh201T: json["18PDH201T"],
        the18Csc305J: json["18CSC305J"],
        the18Ceo406T: json["18CEO406T"],
        the18Csp104L: json["18CSP104L"],
        the18Csc307L: json["18CSC307L"],
      );

  Map<String, dynamic> toJson() => {
        "18CSC303J": the18Csc303J,
        "18LEM110L": the18Lem110L,
        "18CSE354T": the18Cse354T,
        "18CSC304J": the18Csc304J,
        "18CSE386T": the18Cse386T,
        "18CSC350T": the18Csc350T,
        "18PDH201T": the18Pdh201T,
        "18CSC305J": the18Csc305J,
        "18CEO406T": the18Ceo406T,
        "18CSP104L": the18Csp104L,
        "18CSC307L": the18Csc307L,
      };
}

// class UserInfo {
//   UserInfo({
//     required this.registrationNumber,
//     required this.name,
//     required this.batch,
//     required this.mobile,
//     required this.program,
//     required this.department,
//     required this.semester,
//   });

//   final dynamic registrationNumber;
//   final dynamic name;
//   final dynamic batch;
//   final dynamic mobile;
//   final dynamic program;
//   final dynamic department;
//   final String semester;

//   factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
//         registrationNumber: json["Registration Number:"],
//         name: json["Name:"],
//         batch: json["Batch:"],
//         mobile: json["Mobile:"],
//         program: json["Program:"],
//         department: json["Department:"],
//         semester: json["Semester:"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Registration Number:": registrationNumber,
//         "Name:": name,
//         "Batch:": batch,
//         "Mobile:": mobile,
//         "Program:": program,
//         "Department:": department,
//         "Semester:": semester,
//       };
// }
