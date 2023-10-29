// Create a Flutter UI for with lottie animation
// Language: dart

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderMaintenance2 extends StatelessWidget {
  const UnderMaintenance2({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              child: SelectableText(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(194, 80, 39, 157)),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }
}
