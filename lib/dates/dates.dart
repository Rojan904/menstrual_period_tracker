import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:menstraul_period_tracker/predict_date/model/linear_regression.dart';
// import 'package:menstraul_period_tracker/theme.dart';
// import 'package:table_calendar/table_calendar.dart';

// class DatesScreen extends StatefulWidget {
//   const DatesScreen({super.key});

//   @override
//   State<DatesScreen> createState() => _DatesScreenState();
// }

// class _DatesScreenState extends State<DatesScreen> {
//   final DateTime _selectedDay = DateTime.now();
//   DateTime _focusedDay = DateTime.now();
//   CalendarFormat format = CalendarFormat.month;
//   List<CycleData> historicalData = [
//     CycleData(DateTime.now().subtract(const Duration(days: 60)), 30),
//     CycleData(DateTime.now().subtract(const Duration(days: 45)), 28),
//     CycleData(DateTime.now().subtract(const Duration(days: 30)), 32),
//   ];

//   DateTime? _rangeStart;
//   int? _rangeEnd;
//   late DateTime nextMenstrualPeriod;
//   void initState() {
//     var userBox = Hive.box('periodsData');
//     var startDate = userBox.get('periodStartDate');
//     var endDate = userBox.get('periodLength');
//     _rangeStart = startDate;
//     _rangeEnd = endDate;

//     var cycleLength = userBox.get('cycleLength');

//     historicalData.add(CycleData(startDate, cycleLength));
//     if (startDate != null) {
//       int predictedCycleLength = predictNextCycleLength(startDate!);
//       nextMenstrualPeriod =
//           startDate!.add(Duration(days: predictedCycleLength));
//     }
//     super.initState();
//   }

//   int predictNextCycleLength(DateTime startDate) {
//     List<double> x = historicalData
//         .map((data) => data.startDate.difference(startDate).inDays.toDouble())
//         .toList();
//     List<double> y =
//         historicalData.map((data) => data.cycleLength.toDouble()).toList();

//     LinearRegressionModel model = LinearRegressionModel(x, y);

//     // Assuming the user is at the next time step
//     double nextTimeStep = historicalData.length.toDouble();

//     return model.predict(nextTimeStep).round();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TableCalendar(
//         focusedDay: _focusedDay,
//         firstDay: DateTime(1990),
//         lastDay: DateTime(2050),

//         selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
//         // onFormatChanged: (CalendarFormat _format) {
//         //   setState(() {
//         //     format = _format;
//         //   });
//         // },
//         onPageChanged: (focusedDay) {
//           setState(() {
//             _focusedDay = focusedDay;
//           });
//         },
//         daysOfWeekVisible: true,
//         calendarStyle: const CalendarStyle(
//           isTodayHighlighted: true,
//           selectedDecoration:
//               BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
//           selectedTextStyle: TextStyle(color: Colors.white, fontSize: 15),
//           todayDecoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: kPinkColor,
//           ),
//         ),
//         headerStyle: const HeaderStyle(
//             formatButtonVisible: false,
//             titleCentered: true,
//             titleTextStyle: TextStyle(
//                 color: kPrimaryColor,
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold)),
//         rangeStartDay: nextMenstrualPeriod,
//         rangeEndDay: nextMenstrualPeriod.add(Duration(days: _rangeEnd! - 1)),
//         // onRangeSelected: _onRangeSelected,
//         rangeSelectionMode: RangeSelectionMode.toggledOn,
//       ),
//     );
//   }
// }

class DatesScreen extends StatefulWidget {
  const DatesScreen({super.key});

  @override
  State<DatesScreen> createState() => _DatesScreenState();
}

class _DatesScreenState extends State<DatesScreen> {
  late int periodLength;
  late int cycleLength;
  late DateTime startDate, nextDate;
  @override
  void initState() {
    var userBox = Hive.box('periodsData');
    periodLength = userBox.get('periodLength');
    startDate = userBox.get('periodStartDate');
    nextDate = userBox.get('nextDate');
    cycleLength = userBox.get('cycleLength');

    super.initState();
  }

  List<Appointment> getAppointment() {
    List<Appointment> meetings = [];
    final startTime = startDate;
    final endTime = startTime.add(Duration(days: periodLength - 1));
    for (int i = 1; i <= 12; i++) {
      meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: "period",
          color: Colors.blue,
          recurrenceRule:
              "FREQ=DAILY;INTERVAL=${daysBetween(startDate, nextDate)}"));
    }

    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          const AppbarTitle(
            title: "Dates",
          ),
          context),
      body: SfCalendar(
        allowViewNavigation: false,
        view: CalendarView.month,
        dataSource: Meeting(getAppointment()),
      ),
    );
  }
}

class Meeting extends CalendarDataSource {
  Meeting(List<Appointment> source) {
    appointments = source;
  }
}
