import 'package:hive/hive.dart';
part 'logs_model.g.dart';

@HiveType(typeId: 2)
class LogsModel {
  LogsModel(
      {this.logDate, this.bloodFlow, this.moods, this.symptoms, this.notes});
  @HiveField(0)
  DateTime? logDate;
  @HiveField(1)
  num? bloodFlow;
  @HiveField(2)
  String? symptoms;
  @HiveField(3)
  String? moods;
  @HiveField(4)
  String? notes;
}
