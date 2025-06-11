import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditDatesScreen extends StatefulWidget {
  const EditDatesScreen({super.key});

  @override
  State<EditDatesScreen> createState() => _EditDatesScreenState();
}

class _EditDatesScreenState extends State<EditDatesScreen> {
  final DateRangePickerController _controller = DateRangePickerController();
  late List<PickerDateRange> dates;
  final bool _isContains = true;

  @override
  void initState() {
    // var box = Hive.box('periodsData');
    // var containsDateList = box.containsKey('periodsDateList');
    // if (containsDateList) {
    //   var dateList = box.get('periodsDateList');
    //   dates = dateList as List<PickerDateRange>;
    // } else {
    //   _isContains = false;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfDateRangePicker(
        controller: _controller,
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.multiRange,
        enableMultiView: true,
        navigationDirection: DateRangePickerNavigationDirection.vertical,
        navigationMode: DateRangePickerNavigationMode.scroll,
        showNavigationArrow: true,
        headerHeight: 30,
        viewSpacing: 20,
        showActionButtons: true,
        onCancel: () {
          Navigator.pop(context);
        },
        onSubmit: (p0) {
          if (p0 is List<PickerDateRange>) {
            saveDates(p0);
          }
        },
        // initialSelectedRanges: _isContains
        //     ? dates
        //     : [
        //         PickerDateRange(
        //             DateTime.now(), DateTime.now().add(const Duration(days: 3)))
        //       ],
      ),
    );
  }

  saveDates(value) async {
    final List<PickerDateRange> dateRanges = (value as List<PickerDateRange>);
    final DateTime? date = dateRanges.isNotEmpty
        ? dateRanges[dateRanges.length - 1].startDate!
        : null;
    if (date != null && _controller.selectedRanges != null) {
      print("object");

      _controller.selectedRanges = dateRanges;
      log(dateRanges.toString());
      var box = Hive.box('periodsData');
      for (int i = 0; i < dateRanges.length; i++) {
        await box.put('periodsStartDateList', dateRanges[i].startDate);
        await box.put('periodsEndDateList', dateRanges[i].endDate);
      }
      var da = box.get('periodsStartDateList');
      print(da);
      if (mounted) {
        Navigator.pop(
          context,
        );
      }
    }
  }
}
