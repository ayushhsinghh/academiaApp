import 'dart:math';

class MathFunction {
  static double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static double getTotalMarks(List<double> values) {
    double totalMarks = 0;
    for (int i = 0; i < values.length; i++) {
      if (i % 2 == 0) {
        totalMarks += values[i];
      }
    }
    return dp(totalMarks, 2);
  }

  static double getObtainedMarks(List<double> values) {
    double obtainedMarks = 0;
    for (int i = 0; i < values.length; i++) {
      if (i % 2 == 1) {
        obtainedMarks += values[i];
      }
    }
    return dp(obtainedMarks, 2);
  }

  static List<double> getMarks(List<double> values) {
    List<double> marks = [];
    for (int i = 0; i < values.length; i++) {
      if (i % 2 == 1) {
        marks.add(dp(values[i], 1));
      }
    }
    return marks;
  }
}
