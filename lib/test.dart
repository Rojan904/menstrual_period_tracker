import 'package:flutter/material.dart';

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



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? lastMenstrualPeriod;
  int cycleLength = 28;
  List<CycleData> historicalData = [
    CycleData(DateTime.now().subtract(const Duration(days: 60)), 30),
    CycleData(DateTime.now().subtract(const Duration(days: 45)), 28),
    CycleData(DateTime.now().subtract(const Duration(days: 30)), 32),
    // Add more historical data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menstrual Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Enter the start date of your last menstrual period:'),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(lastMenstrualPeriod == null
                  ? 'Select Date'
                  : '${lastMenstrualPeriod!.toLocal()}'),
            ),
            const SizedBox(height: 16),
            const Text('Enter your menstrual cycle length (in days):'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                cycleLength = int.tryParse(value.trim()) ?? 28;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (lastMenstrualPeriod != null) {
                  int predictedCycleLength =
                      predictNextCycleLength(lastMenstrualPeriod!);
                  DateTime nextMenstrualPeriod = lastMenstrualPeriod!
                      .add(Duration(days: predictedCycleLength));
                  _showResultDialog(nextMenstrualPeriod);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select a valid start date.'),
                    ),
                  );
                }
              },
              child: const Text('Predict Next Menstrual Period'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != lastMenstrualPeriod) {
      setState(() {
        lastMenstrualPeriod = picked;
      });
    }
  }

  int predictNextCycleLength(DateTime startDate) {
    List<double> x = historicalData
        .map((data) => data.startDate.difference(startDate).inDays.toDouble())
        .toList();
    List<double> y =
        historicalData.map((data) => data.cycleLength.toDouble()).toList();

    LinearRegressionModel model = LinearRegressionModel(x, y);

    // Assuming the user is at the next time step
    double nextTimeStep = historicalData.length.toDouble();
    return model.predict(nextTimeStep).round();
  }

  void _showResultDialog(DateTime nextMenstrualPeriod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Next Menstrual Period'),
          content: Text(
              'The predicted next menstrual period is: ${nextMenstrualPeriod.toLocal()}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
