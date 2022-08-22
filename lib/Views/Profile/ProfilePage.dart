import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../models/Details.dart';
import 'Components/Drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.studentInfo}) : super(key: key);

  final Details studentInfo;

  @override
  Widget build(BuildContext context) {
    List<List<String>>? facultyIndo = studentInfo.facultyInfo;
    final box = GetStorage('login');
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
        key: _key,
        endDrawer: MyDrawer(userInfo: studentInfo.userInfo!),
        backgroundColor: Colors.blue.shade100,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.short_text),
                  color: Colors.black,
                  onPressed: () => _key.currentState!.openEndDrawer(),
                ),
              ],
              backgroundColor: Colors.blue.shade100,
              // collapsedHeight: 250,
              // snap: true,
              // stretch: true,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Lottie.asset("assets/json/Profilebackground.json",
                    repeat: true),

                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
                // centerTitle: true,
              ),
              expandedHeight: 200,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: facultyIndo!.length, (context, index) {
              List<String>? value = facultyIndo[index];
              double percent = 76.0;
              bool isPractical = value[8].contains('P');
              // print("${value[8].length}");
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: percent > 75
                      ? const LinearGradient(
                          colors: [(Colors.white), Colors.blueAccent],
                        )
                      : const LinearGradient(
                          colors: [Colors.white, Colors.redAccent],
                        ),
                  boxShadow: [
                    // BoxShadow(
                    //   color: (Colors.grey[900])!,
                    // ),
                    BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          // color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  isPractical
                                      ? value[8]
                                          .substring(0, value[8].length - 1)
                                      : value[8],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: isPractical ? 13.0 : 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Center(
                                child: Text(
                                  value[6],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      value[2],
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Subject Code : ${value[1]}",
                                  ),
                                  const SizedBox(width: 15.0),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Faculty : ${value[7]}",
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      value[5],
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Credit : ${value[3]}",
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Room No : ${value[9]}",
                                      // textAlign: TextAlign.left,
                                      maxLines: 3,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
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
            }))
          ],
        ));
  }
}
