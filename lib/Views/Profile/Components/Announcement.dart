import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Announcement extends StatelessWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage('login');
    var map = jsonDecode(box.read('announcement').toString());
    List values = [];
    map.forEach((key, value) {
      values.add(value);
    });
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue.shade100,
        title:
            const Text('Announcements', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: values.length == 0
            ? const Text("No Announcements")
            : ListView.builder(
                itemBuilder: ((context, index) => Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.arrow_forward_ios),
                          title: Text(
                            values[index],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                          color: Colors.black,
                        ),
                      ],
                    )),
                itemCount: values.length),
      ),
    );
  }
}
