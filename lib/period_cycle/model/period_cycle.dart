import 'package:hive_flutter/hive_flutter.dart';
part 'period_cycle.g.dart';

@HiveType(typeId: 1)
class PeriodCycle extends HiveObject {
  PeriodCycle({this.cycleLength, this.periodLength, this.periodStartDate});
  @HiveField(0)
  int? periodLength;
  @HiveField(1)
  int? cycleLength;
  @HiveField(2)
  DateTime? periodStartDate;
  @HiveField(3)
  DateTime? periodEndDate;
}
