import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/home/home_screen.dart';
import 'package:menstraul_period_tracker/shared/back_button.dart';
import 'package:menstraul_period_tracker/shared/primary_button.dart';
import 'package:menstraul_period_tracker/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodStartDatePicker extends StatefulWidget {
  const PeriodStartDatePicker({super.key, required this.controller});
  final PageController controller;
  @override
  State<PeriodStartDatePicker> createState() => _PeriodStartDatePickerState();
}

class _PeriodStartDatePickerState extends State<PeriodStartDatePicker> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, day)) {
      setState(() {
        _selectedDay = day;
        focusedDay = focusedDay;
      });
    }
  }

  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  //   setState(() {
  //     _focusedDay = focusedDay;
  //     _rangeStart = start;
  //     _rangeEnd = end;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(
                onTap: () {
                  widget.controller.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
              ),
              const Text(
                "Almost done. When did your last period start?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                // onFormatChanged: (CalendarFormat _format) {
                //   setState(() {
                //     format = _format;
                //   });
                // },
                onPageChanged: (focused) {
                  setState(() {
                    _focusedDay = focused;
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
                        color: Colors.cyan,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                // rangeStartDay: _rangeStart,
                // rangeEndDay: _rangeEnd,
                // onRangeSelected: _onRangeSelected,
                // rangeSelectionMode: RangeSelectionMode.toggledOn,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                onTap: () async {
                  var box = Hive.box('periodsData');
                  await box.put("periodStartDate", _selectedDay);
                  var periodLenth = box.get('periodLength');
                  await box.put('periodEndDate',
                      _selectedDay.add(Duration(days: periodLenth - 1)));
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                child: const PrimaryButton(buttonText: "Confirm")),
          )
        ],
      ),
    );
  }
}
