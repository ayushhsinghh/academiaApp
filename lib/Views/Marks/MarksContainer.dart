import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      print("$marks");
    }

    double percent = 76.00;
    return Container(
      margin: const EdgeInsets.all(7),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        // color: Color(0xff5264AE),
        borderRadius: BorderRadius.circular(15.0),
        gradient: percent > 75
            ? const LinearGradient(
                colors: [Color(0xff211C65), (Color(0xff7C4179))],
                transform: GradientRotation(-0.785),
              )
            : LinearGradient(
                colors: [(Colors.red.shade300), Colors.redAccent],
              ),
        boxShadow: [
          // BoxShadow(
          //   color: (Colors.grey[900])!,
          // ),
          BoxShadow(
              color: Colors.white12.withOpacity(0.3),
              offset: const Offset(0, 18),
              blurRadius: 3,
              spreadRadius: -10)
        ],
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
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
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: marks.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150.0,
                  mainAxisExtent: 50.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 50.0
                  // crossAxisCount: 2,
                  // childAspectRatio: 1.0,
                  // crossAxisSpacing: 10.0,
                  // mainAxisSpacing: 10.0,
                  ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1FC4DA),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      marks[index].toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
