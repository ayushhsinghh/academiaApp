import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/AcadControllers.dart';
import '../../models/Details.dart';
import '../Marks/MarksContainer.dart';
import 'AttendanceContainer.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key, required this.title}) : super(key: key);
  static const id = 'MyHomePage';
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcadDataController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: FutureBuilder<Details>(
            future: controller
                .getData(), // this now lives it its own AcadDataController class
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    AttendanceBuilder(snapshot),
                    MarksBuilder(snapshot),
                    ProfileBuilder(snapshot),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: ListView.builder(
                          itemBuilder: (_, __) => Container(
                            margin: const EdgeInsets.all(7),
                            height: MediaQuery.of(context).size.height * 0.22,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 25.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.grey.shade300,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 48.0,
                                  height: 68.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          itemCount: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.redAccent,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Marks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }

  AttendanceBuilder(AsyncSnapshot<Details> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.attendance!.length,
        itemBuilder: (context, index) {
          return AttendanceContainer(
            studentInfo: (snapshot.data)!,
            index: index,
          );
        });
  }

  MarksBuilder(AsyncSnapshot<Details> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.marks!.length,
        itemBuilder: (context, index) {
          return MarksContainer(
            studentInfo: (snapshot.data)!,
            index: index,
          );
        });
  }

  ProfileBuilder(AsyncSnapshot<Details> snapshot) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("hello"),
          trailing: Text("$index"),
        );
      },
      itemCount: 14,
    );
  }
}
