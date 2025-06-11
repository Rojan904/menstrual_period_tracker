import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';
import 'package:numberpicker/numberpicker.dart';

class PeriodCyclePicker extends StatefulWidget {
  const PeriodCyclePicker({super.key, required this.controller});
  final PageController controller;
  @override
  State<PeriodCyclePicker> createState() => _PeriodCyclePickerState();
}

class _PeriodCyclePickerState extends State<PeriodCyclePicker> {
  int _currentIntValue = 5;

  _handleValueChanged(num value) {
    // ignore: unnecessary_null_comparison
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          CustomBackButton(
            onTap: () {
              widget.controller.animateToPage(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
          ),
          const Positioned(
            top: 50,
            child: Text(
              "Your average Period length?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: NumberPicker(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  selectedTextStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 30),
                  itemCount: 5,
                  minValue: 1,
                  maxValue: 20,
                  value: _currentIntValue,
                  onChanged: _handleValueChanged),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                onTap: ()async {
                  widget.controller.animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                  var box = Hive.box('periodsData');
                  await box.put("periodLength", _currentIntValue);

                },
                child: const PrimaryButton(buttonText: "Confirm")),
          )
        ],
      ),
    );
  }
}
