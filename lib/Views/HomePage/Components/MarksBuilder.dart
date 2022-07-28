import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../models/Details.dart';
import '../../Marks/MarksPage.dart';

// MarksBuilder(AsyncSnapshot<Details> snapshot) {
//   return snapshot.data!.marks!.isEmpty
//       ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Lottie.asset(
//                 'assets/json/no-data-found.json',
//                 repeat: true,
//               ),
//               const Text(
//                 "No Data Available",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         )
//       : Scaffold(
//           backgroundColor: const Color(0xff30307E),
//           body: ListView.builder(
//               controller: ScrollController(),
//               itemCount: snapshot.data!.marks!.length,
//               itemBuilder: (context, index) {
//                 return MarksContainer(
//                   studentInfo: (snapshot.data)!,
//                   index: index,
//                 );
//               }),
//         );
// }

MarksBuilder(AsyncSnapshot<Details> snapshot) {
  return MarksPage(
    studentInfo: snapshot.data!,
  );
}
