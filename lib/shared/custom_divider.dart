import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key, this.height = 1, this.color})
      : super(key: key);
  final double height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? kDividerColor,
      height: height,
      thickness: 1,
    );
  }
}
