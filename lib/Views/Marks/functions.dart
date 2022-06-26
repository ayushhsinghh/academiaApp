class MathFunction {
  static double getTotalMarks(List<double> values) {
    double totalMarks = 0;
    for (int i = 0; i < values.length; i++) {
      if (i % 2 == 0) {
        totalMarks += values[i];
      }
    }
    return totalMarks;
  }

  static double getObtainedMarks(List<double> values) {
    double obtainedMarks = 0;
    for (int i = 0; i < values.length; i++) {
      if (i % 2 == 1) {
        obtainedMarks += values[i];
      }
    }
    return obtainedMarks;
  }

  static List<double> getMarks(List<double> values) {
    List<double> marks = [];
    for (int i = 0; i < values.length; i++) {
      if (i % 2 == 1) {
        marks.add(values[i]);
      }
    }
    return marks;
  }
}
