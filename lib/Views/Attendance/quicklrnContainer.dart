import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:srmacademia/models/quicklrn.dart';

import 'Components/AttendanceCalc.dart';

class QuicklrnAttendanceContainer extends StatelessWidget {
  const QuicklrnAttendanceContainer(
      {Key? key, required this.studentInfo, required this.index})
      : super(key: key);

  final int index;
  final QuicklrnApi studentInfo;

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
    List value = studentInfo.attendance[index];
    double percent = value[4] + .0;
    String name = value[0];
    String subjectCode = value[1];
    String subjecttype =
        subjectCode[subjectCode.length - 1] == 'L' ? 'Practical' : 'Theory';
    int total = value[2];
    int present = value[3];
    int absent = total - present;
    // double percent1 = 76.0;
    // int canBunk = (total * 0.25 - absent).truncate();
    int canBunk = getCanbunk(total, absent);
    int classRequired = (absent * 4 - total).toInt();
    // int present = int.parse(value[5]) - int.parse(value[6]);
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
            total: total.toString(),
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
                            subjectCode,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            subjecttype,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              name,
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
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      total.toString(),
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
                      absent.toString(),
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
