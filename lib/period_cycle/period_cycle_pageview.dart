import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/period_cycle/cycle_length_picker.dart';
import 'package:menstraul_period_tracker/period_cycle/period_cycle_picker.dart';
import 'package:menstraul_period_tracker/period_cycle/period_start_date_picker.dart';
import 'package:menstraul_period_tracker/theme.dart';

class PeriodCyclePageView extends StatefulWidget {
  const PeriodCyclePageView({super.key});

  @override
  State<PeriodCyclePageView> createState() => _PeriodCyclePageViewState();
}

class _PeriodCyclePageViewState extends State<PeriodCyclePageView> {
  late int index;
  late Material materialButton;

  int currentPage = 0;
  int numPages = 3;
  PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page.toInt();
              });
            },
            children: [
              CycleLengthPicker(
                controller: controller,
              ),
              PeriodCyclePicker(
                controller: controller,
              ),
              PeriodStartDatePicker(controller: controller,)
            ],
          ),
          if (currentPage <= numPages)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: DotsIndicator(
                  dotsCount: numPages,
                  position: currentPage.toDouble(),
                  decorator: const DotsDecorator(
                      activeColor: kPrimaryColor, size: Size(6, 6)),
                ),
              ),
            )
        ],
      ),
    );
  }
}
