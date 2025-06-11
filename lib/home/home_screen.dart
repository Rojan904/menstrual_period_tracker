import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/calendar/calendar_screen.dart';
import 'package:menstraul_period_tracker/dates/dates.dart';
import 'package:menstraul_period_tracker/logs/logs_screen.dart';
import 'package:menstraul_period_tracker/settings/settings.dart';
import 'package:menstraul_period_tracker/shared/cancel_dialog.dart';
import 'package:menstraul_period_tracker/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const CalendarScreen(),
    const DatesScreen(),
    const LogsScreen(),
    const Settings(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (BuildContext willPopContext) => CancelDialog(
                  title: "Are you sure you want to close this application?",
                  yesWarn: "Yes",
                  noWarn: "Cancel",
                  onPressed: () => exit(0),
                ));
        return false;
      },
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          backgroundColor: Colors.white,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kDarkGreyColor,

          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, color: kDarkGreyColor),
                label: 'Calender',
                activeIcon: Icon(Icons.calendar_today, color: kPrimaryColor)),
            BottomNavigationBarItem(
                icon: Icon(Icons.dataset, color: kDarkGreyColor),
                label: 'Dates',
                activeIcon: Icon(Icons.dataset, color: kPrimaryColor)),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up, color: kDarkGreyColor),
                label: 'Logs',
                activeIcon: Icon(Icons.trending_up, color: kPrimaryColor)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: kDarkGreyColor),
                label: 'Settings',
                activeIcon: Icon(Icons.settings, color: kPrimaryColor)),
          ],
        ),
      ),
    );
  }
}
