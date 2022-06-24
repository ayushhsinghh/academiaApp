import 'package:flutter/material.dart';
import 'package:srmacadmia/models/Details.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MarksContainer extends StatelessWidget {
  const MarksContainer(
      {Key? key, required this.studentInfo, required this.index})
      : super(key: key);
  final Details studentInfo;
  final int index;

  @override
  Widget build(BuildContext context) {
    String param = studentInfo.marks!.keys.elementAt(index);
    List<String>? value = studentInfo.attendance![param];
    double percent = 76.00;
    return Container(
      margin: const EdgeInsets.all(7),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
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
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "param",
                        ),
                        const SizedBox(width: 15.0),
                        Text(
                          "value![2]",
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            "value[1]",
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 18,
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
                          progressColor: percent > 75
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "value[1]",
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
