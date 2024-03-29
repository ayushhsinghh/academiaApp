import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../models/Details.dart';
import '../../Controllers/CalculatorController.dart';
import 'Components/AttendanceCalc.dart';

class AttendanceContainer extends StatelessWidget {
  const AttendanceContainer(
      {Key? key, required this.studentInfo, required this.index})
      : super(key: key);

  final int index;
  final Details studentInfo;

  int getCanbunk(int total, int absent) {
    int canbunk = 0;
    int temp = total;
    while (absent / temp <= 0.25) {
      canbunk = (temp * 0.25 - absent).toInt();
      if (canbunk == 0) canbunk = 1;
      absent = absent + canbunk;
      temp = temp + canbunk;
    }
    if (temp != total) return (temp - total) - 1;
    return canbunk;
  }

  @override
  Widget build(BuildContext context) {
    String param = studentInfo.attendance!.keys.elementAt(index);
    List<String>? value = studentInfo.attendance![param];
    double percent = double.parse(value![7]);
    // double percent1 = 76.0;
    // int canBunk = (int.parse(value[5]) * 0.25 - int.parse(value[6])).toInt();
    int canBunk = getCanbunk(int.parse(value[5]), int.parse(value[6]));
    int classRequired = int.parse(value[6]) * 4 - int.parse(value[5]).toInt();
    int present = int.parse(value[5]) - int.parse(value[6]);
    if (kDebugMode) {
      print("running");
    }
    return GestureDetector(
      onLongPress: () {
        // final controller = Get.put(CalcController());
        Get.defaultDialog(
          backgroundColor: Colors.blue.shade100,
          title: "Attendance Calculator",
          titlePadding: const EdgeInsets.all(15),
          content: AttendanceCalc(
            total: value[5],
            present: present.toString(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: percent < 75
              ? const LinearGradient(
                  colors: [Colors.redAccent, Colors.white],
                )
              : const LinearGradient(
                  colors: [Colors.greenAccent, Colors.white],
                ),
          boxShadow: [
            // BoxShadow(
            //   color: (Colors.grey[900])!,
            // ),
            percent >= 75
                ? BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.5),
                    offset: const Offset(0, 18),
                    blurRadius: 3,
                    spreadRadius: -10)
                : BoxShadow(
                    color: Colors.redAccent.withOpacity(0.5),
                    offset: const Offset(0, 18),
                    blurRadius: 3,
                    spreadRadius: -10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            param,
                          ),
                          const SizedBox(width: 15.0),
                          Text(
                            value[2],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              value[1],
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          CircularPercentIndicator(
                            radius: 27.0,
                            percent: percent / 100,
                            animation: true,
                            center: Text(
                              '$percent%',
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            progressColor: percent == 75
                                ? Colors.yellow.shade800
                                : percent > 75
                                    ? Colors.green.shade600
                                    : Colors.red.shade600,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              value[3],
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      value[5],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      "Total Class",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      present.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      "Present",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      value[6],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      "Absent",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      percent > 75 ? "${canBunk}" : "${classRequired}",
                      style: TextStyle(
                          color: (percent < 75.0)
                              ? Colors.redAccent
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      percent >= 75 ? "Can Bunk" : "Required",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
