class FilterOptionModel {
  String? filterText;
  bool? icon;
  String? filterType;
  FilterOptionModel({this.filterText, this.icon, this.filterType});
}

List<FilterOptionModel> symptomsOptions = [
  FilterOptionModel(
      filterText: "Abdominal cramps", icon: false, filterType: "1"),
  FilterOptionModel(filterText: "Backaches", icon: false, filterType: "2"),
  FilterOptionModel(filterText: "Bloating", icon: false, filterType: "3"),
  FilterOptionModel(filterText: "Cramps", icon: false, filterType: "4"),
  FilterOptionModel(filterText: "Fatigue", icon: false, filterType: "5"),
  FilterOptionModel(filterText: "Bleeding", icon: false, filterType: "6"),
  FilterOptionModel(filterText: "Headaches", icon: false, filterType: "7"),
];
List<FilterOptionModel> moodOptions = [
  FilterOptionModel(filterText: "Depressed", icon: false, filterType: "1"),
  FilterOptionModel(filterText: "Emotional", icon: false, filterType: "2"),
  FilterOptionModel(filterText: "Exhausted", icon: false, filterType: "3"),
  FilterOptionModel(filterText: "Normal", icon: false, filterType: "4"),
  FilterOptionModel(filterText: "Sad", icon: false, filterType: "5"),
  FilterOptionModel(filterText: "Sleepy", icon: false, filterType: "6"),
  FilterOptionModel(filterText: "Stressed", icon: false, filterType: "7"),
  FilterOptionModel(filterText: "Tense", icon: false, filterType: "8"),
];
