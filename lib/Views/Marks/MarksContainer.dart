import 'package:flutter/material.dart';
import 'package:srmacadmia/Views/Marks/Functions.dart';
import 'package:srmacadmia/models/Details.dart';

class MarksContainer extends StatelessWidget {
  const MarksContainer(
      {Key? key, required this.studentInfo, required this.index})
      : super(key: key);
  final Details studentInfo;
  final int index;

  @override
  Widget build(BuildContext context) {
    String param = studentInfo.marks!.keys.elementAt(index);
    List<double>? value = studentInfo.marks![param];
    double totalMark = 0;
    double obtainedMark = 0;
    List<double> marks = [];
    if (value != null) {
      totalMark = MathFunction.getTotalMarks(value);
      obtainedMark = MathFunction.getObtainedMarks(value);
      marks = MathFunction.getMarks(value);
    }
    // print("$param $totalMark $obtainedMark $marks");

    double percent = 76.00;
    return Container(
      margin: const EdgeInsets.all(7),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: percent > 75
            ? LinearGradient(
                colors: [(Colors.green.shade400), Colors.greenAccent],
              )
            : LinearGradient(
                colors: [(Colors.red.shade300), Colors.redAccent],
              ),
        boxShadow: [
          // BoxShadow(
          //   color: (Colors.grey[900])!,
          // ),
          BoxShadow(
              color: Colors.green.withOpacity(0.5),
              offset: const Offset(0, 18),
              blurRadius: 3,
              spreadRadius: -10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 50.0,
            // color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    param,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "${obtainedMark.toString()}/${totalMark.toString()}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "2",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                    "value[2]",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    "Absent",
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "value[1]",
                    style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    "Can Bunk",
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
