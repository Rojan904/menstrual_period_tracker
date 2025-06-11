class CycleData {
  final DateTime startDate;
  final int cycleLength;

  CycleData(this.startDate, this.cycleLength);
}

class LinearRegressionModel {
  double slope = 0;
  double intercept = 0;

  LinearRegressionModel(List<double> x, List<double> y) {
    int n = x.length;

    double sumX = x.reduce((a, b) => a + b);
    double sumY = y.reduce((a, b) => a + b);

    double meanX = sumX / n;
    double meanY = sumY / n;

    double numerator = 0;
    double denominator = 0;

    for (int i = 0; i < n; i++) {
      numerator += (x[i] - meanX) * (y[i] - meanY);
      denominator += (x[i] - meanX) * (x[i] - meanX);
    }

    slope = numerator / denominator;
    intercept = meanY - slope * meanX;
  }

  double predict(double x) {
    return slope * x + intercept;
  }
}
