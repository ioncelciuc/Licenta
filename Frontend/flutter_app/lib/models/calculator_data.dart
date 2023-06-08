import 'package:flutter_app/models/counter.dart';
import 'package:hive/hive.dart';

part 'calculator_data.g.dart';

@HiveType(typeId: 21)
class CalculatorData {
  @HiveField(0)
  List<int> lp1Evo;

  @HiveField(1)
  List<int> lp2Evo;

  @HiveField(2)
  int lp1;

  @HiveField(3)
  int lp2;

  @HiveField(4)
  bool lp1Selected = true;

  @HiveField(5)
  List<Counter> counters;

  CalculatorData({
    required this.lp1Evo,
    required this.lp2Evo,
    required this.lp1,
    required this.lp2,
    required this.lp1Selected,
    required this.counters,
  });
}
