import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
String periodDay(int daysBetween) {
  switch (daysBetween) {
    case 0:
      return "5th";
    case 1:
      return "4th";
    case 2:
      return "3rd";
    case 3:
      return "2nd";
    case 4:
      return "1st";
  }
  return "";
}
int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
