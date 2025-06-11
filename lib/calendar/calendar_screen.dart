import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:menstraul_period_tracker/calendar/edit_dates_screen.dart';
import 'package:menstraul_period_tracker/logs/add_logs.dart';
import 'package:menstraul_period_tracker/notification/notification_api.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/test.dart';
import 'package:menstraul_period_tracker/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;

  // void _onDaySelected(DateTime day, DateTime focusedDay) {
  //   if (!isSameDay(_selectedDay, day)) {
  //     setState(() {
  //       _selectedDay = day;
  //       _focusedDay = focusedDay;
  //       print(_selectedDay.toString().split(" ")[0]);
  //     });
  //   }
  // }

  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  //   setState(() {
  //     _focusedDay = focusedDay;
  //     _rangeStart = start!;
  //     _rangeEnd = end!;
  //   });
  // }
  final _events = {
    DateTime(2021, 6, 22): [
      'Meeting URUS',
      'Testing Danai Mobile',
      'Weekly Report',
      'Weekly Meeting'
    ],
    DateTime(2023, 10, 25): ['Weekly Testing'],
    DateTime(2023, 12, 4): ['Weekly Testing'],
    DateTime(2023, 10, 11): ['Weekly Testing'],
    DateTime(2023, 11, 18): ['Weekly Testing'],
  };
  List<Object> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  List<CycleData> historicalData = [
    CycleData(DateTime.now().subtract(const Duration(days: 60)), 30),
    CycleData(DateTime.now().subtract(const Duration(days: 45)), 28),
    CycleData(DateTime.now().subtract(const Duration(days: 30)), 32),
  ];
  late DateTime nextMenstrualPeriod;
  @override
  void initState() {
    var userBox = Hive.box('periodsData');
    var startDate = userBox.get('periodStartDate');
    var endDate = userBox.get('periodEndDate');
    _rangeStart = startDate;
    _rangeEnd = endDate;

    var cycleLength = userBox.get('cycleLength');

    historicalData.add(CycleData(startDate, cycleLength));
    if (startDate != null) {
      int predictedCycleLength = predictNextCycleLength(startDate!);
      nextMenstrualPeriod =
          startDate!.add(Duration(days: predictedCycleLength));
      userBox.put('nextDate', nextMenstrualPeriod);
      showNotification();
      scheduleNotification();
    }
    super.initState();
  }

  showNotification() async {
    var box = Hive.box('common');
    var getNot = box.containsKey('isNotificationDisplayed');
    if (getNot) {
      var isNotificationDisplayed = box.get('isNotificationDisplayed');
      if (isNotificationDisplayed == true) {}
    } else {
      await NotificationApi.showNotification(
        title: "Reminder",
        body:
            "Your next period is scheduled on ${DateFormat('dd MMM yyy').format(DateTime.parse(nextMenstrualPeriod.toString()))}",
        paylod: "Coming",
      );
      await box.put('isNotificationDisplayed', true);
    }
  }

  scheduleNotification() async {
    var box = Hive.box('common');
    var getNot = box.containsKey('isNotificationOn');
    if (getNot) {
      var isNotificationOn = box.get('isNotificationOn');
      if (isNotificationOn == true) {
        await NotificationApi.showScheduledNotification(
          title: "Reminder",
          body: "Your period starts tomorrow.",
          payload: "Coming",
          scheduledDate: nextMenstrualPeriod.subtract(const Duration(days: 1)),
        );
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(
        context: context,
        color: kPrimaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: kPrimaryColor,
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: kWhiteColor, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: DateTime.now().isBefore(_rangeEnd!)
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            periodDay(daysBetween(
                                                DateTime.now(), _rangeEnd!)),
                                            style: text16.copyWith(
                                                color: kWhiteColor),
                                          ),
                                          Text(
                                            "day of Period",
                                            style: text16.copyWith(
                                                color: kDividerColor,
                                                fontSize: 12),
                                          )
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${daysBetween(DateTime.now(), nextMenstrualPeriod)}",
                                            style: text16.copyWith(
                                                color: kWhiteColor),
                                          ),
                                          Text(
                                            "days until Period",
                                            style: text16.copyWith(
                                                color: kDividerColor,
                                                fontSize: 12),
                                          )
                                        ],
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2050),
                    onDaySelected: (date, events) {},
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    // onFormatChanged: (CalendarFormat _format) {
                    //   setState(() {
                    //     format = _format;
                    //   });
                    // },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                    },
                    daysOfWeekVisible: true,
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                          color: kPrimaryColor, shape: BoxShape.circle),
                      selectedTextStyle:
                          TextStyle(color: Colors.white, fontSize: 15),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPinkColor,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    // onRangeSelected: _onRangeSelected,
                    rangeSelectionMode: RangeSelectionMode.toggledOn,
                    eventLoader: (day) => _getEventsForDay(day)),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditDatesScreen(),
                        ),
                      );
                    },
                    child: const CustomContainer.rectangle(
                        borderColor: kPinkColor,
                        width: double.infinity,
                        widget: Center(
                            child: Text(
                          "Edit Period Dates",
                          style: TextStyle(color: kPinkColor),
                        ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomContainer.rectangle(
                      width: double.infinity,
                      widget: Text(
                          "Your predicted next menstrual period starts on ${DateFormat('dd MMM yyy').format(DateTime.parse(nextMenstrualPeriod.toString()))}")),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                backgroundColor: kPrimaryColor,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddLogsScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
