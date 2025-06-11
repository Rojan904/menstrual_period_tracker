import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/logs/model/logs_model.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';

class LogsDetailScreen extends StatefulWidget {
  const LogsDetailScreen({super.key, required this.index, required this.logs});
  final int index;
  final LogsModel logs;
  @override
  State<LogsDetailScreen> createState() => _LogsDetailScreenState();
}

class _LogsDetailScreenState extends State<LogsDetailScreen> {
  late int periodLength;
  late int cycleLength;
  @override
  void initState() {
    var box = Hive.box('periodsData');
    periodLength = box.get('periodLength');
    cycleLength = box.get('cycleLength');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: CustomBackButton(
                          bottomPadding: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 30),
                        child: Text(
                          "Log Details",
                          style: text16.copyWith(fontSize: 18),
                        ),
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
                const CustomDivider()
              ],
            ),
            context),
        body: SingleChildScrollView(
            child: Padding(
          padding: kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DatePicker(
                widget.logs.logDate!.isBefore(DateTime.now())
                    ? widget.logs.logDate!
                    : DateTime.now(),
                initialSelectedDate: widget.logs.logDate,
                selectionColor: kPrimaryColor,
                height: 90,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomContainer.rectangle(
                width: double.infinity,
                widget: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Period Length",
                          style: text16,
                        ),
                        Text(
                          "$periodLength",
                          style: text16.copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cycle Length",
                          style: text16,
                        ),
                        Text(
                          "$cycleLength",
                          style: text16.copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomContainer.rectangle(
                width: double.infinity,
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Blood Flow",
                      style: text16,
                    ),
                    RatingComponent(
                      initialRating: widget.logs.bloodFlow != null
                          ? widget.logs.bloodFlow!.toDouble()
                          : 0.0,
                      color: kPrimaryColor,
                      itemSize: 20,
                      ignoreGestures: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              widget.logs.symptoms != null && widget.logs.symptoms != ""
                  ? CommonDetailsComponent(
                      title: "Symptoms",
                      subTitle: widget.logs.symptoms!,
                    )
                  : const SizedBox(),
              widget.logs.moods != null && widget.logs.moods != ""
                  ? CommonDetailsComponent(
                      title: "Moods",
                      subTitle: widget.logs.moods!,
                    )
                  : const SizedBox(),
              widget.logs.notes != null && widget.logs.notes != ""
                  ? CommonDetailsComponent(
                      title: "Note",
                      subTitle: widget.logs.notes!,
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        )));
  }
}

class CommonDetailsComponent extends StatelessWidget {
  const CommonDetailsComponent({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomContainer.rectangle(
          width: double.infinity,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: text16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subTitle,
                      style:
                          text16.copyWith(fontSize: 12, color: kSecondaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
