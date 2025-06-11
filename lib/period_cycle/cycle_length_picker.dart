import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';
import 'package:numberpicker/numberpicker.dart';

class CycleLengthPicker extends StatefulWidget {
  const CycleLengthPicker({super.key, required this.controller});
  final PageController controller;
  @override
  State<CycleLengthPicker> createState() => _CycleLengthPickerState();
}

class _CycleLengthPickerState extends State<CycleLengthPicker> {
  int _currentIntValue = 28;

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
          const CustomBackButton(),
          const Positioned(
            top: 50,
            child: Text(
              "Your average Cycle length?",
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
                  maxValue: 100,
                  value: _currentIntValue,
                  onChanged: _handleValueChanged),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                onTap: () async {
                  widget.controller.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);

                  var box = Hive.box('periodsData');
                  await box.put("cycleLength", _currentIntValue);
                },
                child: const PrimaryButton(buttonText: "Confirm")),
          )
        ],
      ),
    );
  }
}
