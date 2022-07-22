import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/Details.dart';
import 'functions.dart';

class MarksPage extends StatelessWidget {
  const MarksPage({Key? key, required this.studentInfo}) : super(key: key);

  final Details studentInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff30307E),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color.fromARGB(255, 76, 76, 175),
              // collapsedHeight: 250,
              // snap: true,
              // stretch: true,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Lottie.asset("assets/json/lf20_bdopy9fg.json",
                    repeat: true, fit: BoxFit.cover),
              ),
              expandedHeight: 110,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: studentInfo.marks!.length, (context, index) {
              String param = studentInfo.marks!.keys.elementAt(index);
              List<double>? value = studentInfo.marks![param];
              double totalMark = 0;
              double obtainedMark = 0;
              List<double> marks = [];
              // value = [15, 10.152, 10, 5, 20, 16.555, 10, 5.3315];
              if (value != null) {
                totalMark = MathFunction.getTotalMarks(value);
                obtainedMark = MathFunction.getObtainedMarks(value);
                marks = MathFunction.getMarks(value);
              }
              // marks = [15.152, 9, 2, 1];
              if (kDebugMode) {
                print("$marks");
              }

              double percent = 76.00;
              // print("${value[8].length}");
              return Container(
                margin: const EdgeInsets.all(7),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                decoration: BoxDecoration(
                  // color: Color(0xff5264AE),
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [Color(0xff211C65), (Color(0xff7C4179))],
                    transform: GradientRotation(-0.785),
                  ),

                  boxShadow: [
                    // BoxShadow(
                    //   color: (Colors.grey[900])!,
                    // ),
                    BoxShadow(
                        color:
                            Color.fromARGB(255, 238, 158, 238).withOpacity(0.3),
                        offset: const Offset(0, 18),
                        blurRadius: 2,
                        spreadRadius: -12)
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      // color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              param,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Text(
                            "${obtainedMark.toString()}/${totalMark.toString()}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 15.0),
                    marks.isEmpty
                        ? Column(
                            children: const [
                              Text(
                                "No data Available",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: marks.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150.0,
                              mainAxisExtent: 50.0,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 50.0,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  // color: Color.fromARGB(255, 200, 121, 236),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        param.contains("Practical")
                                            ? "P-${index + 1}"
                                            : "CLA-${index + 1}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        marks[index].toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                  ],
                ),
              );
            }))
          ],
        ));
  }
}
