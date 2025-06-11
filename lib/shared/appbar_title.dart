import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: text16.copyWith(color: kBlackColor, fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomDivider()
        ],
      ),
    );
  }
}
