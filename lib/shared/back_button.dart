import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/theme.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key, this.onTap,  this.bottomPadding=20.0}) : super(key: key);
  final Function()? onTap;
  final double bottomPadding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.maybePop(context);

            // Navigator.of(context).pop();
          },
      child:  SizedBox(
        child: Padding(
          padding: EdgeInsets.only(bottom:bottomPadding),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }
}
