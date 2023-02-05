import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:srmacademia/models/quicklrn.dart';

import '../../../models/Details.dart';
import '../../Marks/MarksPage.dart';

MarksBuilder(AsyncSnapshot<Details> snapshot) {
  return MarksPage(
    studentInfo: snapshot.data!,
  );
}
