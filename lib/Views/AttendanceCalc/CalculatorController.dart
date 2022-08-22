import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalcController extends GetxController {
  // var presentEditing = TextEditingController(text: '0').obs;
  // var totalEditing = TextEditingController(text: '0').obs;
  int canBank = 0, required = 0;
  var total = 0.obs;
  var present = 0.obs;
  var result = 0.obs;

  void calculate() {
    // total = int.parse(totalEditing.value.text);
    // absent = total - int.parse(presentEditing.value.text);
    // canBank = (total * 0.25 - absent).toInt();
    // required = (total * 4 - absent).toInt();
    result.value = total.value + present.value;
  }
}
