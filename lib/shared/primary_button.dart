import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final double? height;
  final Color? color;
  const PrimaryButton(
      {super.key, required this.buttonText, this.height, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color ?? kPrimaryColor),
      child: Text(
        buttonText,
        style: textButton.copyWith(color: kWhiteColor),
      ),
    );
  }
}
