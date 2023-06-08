import 'package:hive/hive.dart';

part 'counter.g.dart';

@HiveType(typeId: 20)
class Counter {
  @HiveField(0)
  int greenCounters;

  @HiveField(1)
  int blueCounters;

  @HiveField(2)
  int redCounters;

  Counter({
    this.greenCounters = 0,
    this.blueCounters = 0,
    this.redCounters = 0,
  });
}
