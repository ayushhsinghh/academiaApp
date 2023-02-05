import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalcController extends GetxController {
  TextEditingController presentEditing = TextEditingController();
  TextEditingController totalEditing = TextEditingController();
  int canBank = 0, required = 0;
  var total = 0.obs;
  var present = 0.obs;
  var result = 0.obs;
  var isError = false.obs;
  var isBankable = true.obs;

  int getCanbunk(int total, int absent) {
    int canbunk = 0;
    int temp = total;
    while (absent / temp <= 0.25) {
      canbunk = (temp * 0.25 - absent).toInt();
      if (canbunk == 0) canbunk = 1;
      absent = absent + canbunk;
      temp = temp + canbunk;
    }
    if (temp != total) return (temp - total) - 1;
    return canbunk;
  }

  void calculate() {
    // total = int.parse(totalEditing.value.text);
    var absent = (total.value - present.value);
    canBank = getCanbunk(total.value, absent);
    required = (absent * 4 - total.value).toInt();
    isBankable.value = (canBank >= 0) & true & (required < 0);
    result.value = isBankable.value ? canBank : required;
  }
}
