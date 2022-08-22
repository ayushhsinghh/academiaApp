import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:srmacademia/models/Calender.dart';

import '../../Controllers/AcadControllers.dart';
import 'Components.dart/SimmerEffect.dart';

class CalenderEvenPage extends StatelessWidget {
  const CalenderEvenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AcadDataController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Planner - EVEN"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xff232849),
      body: FutureBuilder<Calender>(
          future: controller.getCalender(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.calEven.length,
                  itemBuilder: ((context, index) {
                    String param = snapshot.data!.calEven.keys.elementAt(index);
                    List<List<dynamic>>? value = snapshot.data!.calEven[param];

                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: Color(0xffF4F5F9),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff67B3E4),
                            Color(0xff00E6F6),
                            // Color(0xff95A3E0),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: ExpansionTile(
                          trailing: const Icon(
                            Icons.swipe_down,
                            color: Color(0xff95A3E0),
                          ),
                          title: Text(
                            param.substring(3),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: const Color(0xffEDEADE),
                          textColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          // collapsedBackgroundColor: Color(0xffF9F6EE),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value!.length,
                              itemBuilder: (context, index) {
                                // double percent = 76.00;
                                bool isHoliday =
                                    value[index][3].toString() == '-';
                                // print(value[index][3].toString());
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 7),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 7, right: 7, top: 10, bottom: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: isHoliday
                                        ? const Color(0xffE99DCB)
                                        : const Color(0xff8099E9),
                                    // gradient: const LinearGradient(
                                    //   colors: [
                                    //     (Colors.white),
                                    //     Colors.blueAccent
                                    //   ],
                                    // ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: isHoliday
                                              ? Colors.red.withOpacity(0.5)
                                              : Colors.blue.withOpacity(0.5),
                                          offset: const Offset(0, 15),
                                          blurRadius: 3,
                                          spreadRadius: -10)
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            // color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    value[index][0].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            // color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    value[index][1],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        value[index][2],
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            // color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    value[index][3].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5.0),
                                    ],
                                  ),
                                );
                              },
                            )
                          ]),
                    );
                  }));
            }
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/json/UnderMaintenance.json',
                    // height: MediaQuery.of(context).size.height * 0.3,
                    // width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Something Went Wrong \nError: ${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              );
            }
            return shimmerEffectCalender(context);
          }),
    );
  }
}
