import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:menstraul_period_tracker/logs/model/logs_model.dart';
import 'package:menstraul_period_tracker/logs/model/option_model.dart';

import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';

class AddLogsScreen extends StatefulWidget {
  const AddLogsScreen({super.key});

  @override
  State<AddLogsScreen> createState() => _AddLogsScreenState();
}

class _AddLogsScreenState extends State<AddLogsScreen> {
  DateTime _selectedValue = DateTime.now();
  double initialRating = 0.0;
  final List filterTypeList = ['a', 'b'];
  List<String> selectedSymptoms = [];
  List<String> selectedMoods = [];
  final notesController = TextEditingController();
  final DatePickerController _controller = DatePickerController();
  void executeAfterBuild() {
    _controller.animateToSelection();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild());

    return Scaffold(
      appBar: emptyAppBar(
        context: context,
        statusBarIconBrightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Add Logs",
                      style: text16.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox()
                ],
              ),
              DatePicker(
                DateTime(2023),
                controller: _controller,
                initialSelectedDate: _selectedValue,
                selectionColor: kPrimaryColor,
                height: 90,
                deactivatedColor: kDarkGreyColor,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomContainer.rectangle(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Blood Flow",
                      style: text16,
                    ),
                    RatingComponent(
                      initialRating: initialRating,
                      color: kPrimaryColor,
                      onRatingUpdate: (rating) {
                        initialRating = rating;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomContainer.rectangle(
                width: double.infinity,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Symptoms",
                      style: text16,
                    ),
                    StarRatingMultiChip(
                        filtertype: symptomsOptions,
                        onSelectionChanged: (selected) {
                          setState(() {
                            selectedSymptoms = selected;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomContainer.rectangle(
                width: double.infinity,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Moods",
                      style: text16,
                    ),
                    StarRatingMultiChip(
                        filtertype: moodOptions,
                        onSelectionChanged: (selected) {
                          setState(() {
                            selectedMoods = selected;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomContainer.rectangle(
                width: double.infinity,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Note",
                      style: text16,
                    ),
                    TextField(
                      controller: notesController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter your text here",
                          hintStyle: text16.copyWith(
                              fontSize: 12, color: kSecondaryColor)),
                      style: text16.copyWith(fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
            onTap: addLogs, child: const PrimaryButton(buttonText: "Save")),
      ),
    );
  }

  addLogs() async {
    var box = Hive.box<LogsModel>('periodsLogs');
    var symptoms = selectedSymptoms.join(',');
    var moods = selectedMoods.join(',');
    var logs = LogsModel(
        logDate: _selectedValue,
        bloodFlow: initialRating,
        symptoms: symptoms,
        moods: moods,
        notes: notesController.text.toString());
    await box.add(logs).then((value) {
      setState(() {
        notesController.text = "";
        selectedMoods.clear();
        selectedSymptoms.clear();
        initialRating = 0.0;
      });
      CustomSnackbar.buildSnackbar(context, "Logs added successfully.",
          "Congratulations", ContentType.success);
    }).onError((error, stackTrace) => CustomSnackbar.buildSnackbar(
        context, "Error adding logs", "Oh, Snap", ContentType.failure));
  }
}
