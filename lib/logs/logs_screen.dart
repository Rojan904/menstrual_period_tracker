import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:menstraul_period_tracker/logs/logs_detail_screen.dart';
import 'package:menstraul_period_tracker/logs/model/logs_model.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  late final Box<LogsModel> box;
  @override
  void initState() {
    box = Hive.box<LogsModel>('periodsLogs');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          const AppbarTitle(
            title: "Logs",
          ),
          context),
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, box, widget) {
                  if (box.isEmpty) {
                    return const Center(
                      child: Text('You have no logs currently.'),
                    );
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: box.length,
                      itemBuilder: (ctx, index) {
                        var currentbox = box;
                        var logsData = currentbox.getAt(index)!;

                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LogsDetailScreen(
                                        index: index,
                                        logs: logsData,
                                      ))),
                          child: CustomContainer.rectangle(
                            width: double.infinity,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(
                                              logsData.logDate.toString())),
                                      style:
                                          text16.copyWith(color: kPrimaryColor),
                                    ),
                                    RatingComponent(
                                        ignoreGestures: true,
                                        color: kPrimaryColor,
                                        itemSize: 20,
                                        itemCount: logsData.bloodFlow!.toInt(),
                                        initialRating: double.parse(
                                            logsData.bloodFlow.toString())),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Symptoms: ",
                                      style: text16.copyWith(fontSize: 14),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          logsData.symptoms!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: text16.copyWith(
                                              fontSize: 12,
                                              color: kSecondaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Moods: ",
                                      style: text16.copyWith(fontSize: 14),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          logsData.moods!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: text16.copyWith(
                                              fontSize: 12,
                                              color: kSecondaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
