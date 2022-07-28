// Create a Flutter UI for with lottie animation
// Language: dart

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderMaintenance extends StatelessWidget {
  const UnderMaintenance({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),

            Lottie.asset(
              'assets/json/UnderMaintenance.json',
              repeat: true,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(15),
                child: SelectableText(message)),
            // const SizedBox(
            //   height: 20,
            // ),
            Column(
              children: const [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Try Restarting the App"),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
