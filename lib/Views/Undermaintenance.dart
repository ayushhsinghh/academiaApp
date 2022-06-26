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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/UnderMaintenance.json',
              repeat: true,
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
