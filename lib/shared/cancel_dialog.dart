import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';

class CancelDialog extends StatelessWidget {
  const CancelDialog(
      {Key? key,
      required this.title,
      this.yesWarn = "Yes",
      this.noWarn = "No",
      this.onPressed})
      : super(key: key);
  final String? title, yesWarn, noWarn;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Wrap(
        children: [
          SizedBox(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Text(
                    title!,
                    style: text16,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const CustomDivider(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onPressed,
                        child: PrimaryButton(
                          buttonText: yesWarn!,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: PrimaryButton(
                          buttonText: noWarn!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
