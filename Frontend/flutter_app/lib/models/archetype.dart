import 'package:hive/hive.dart';

part 'archetype.g.dart';

@HiveType(typeId: 2)
class Archetype {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String archetypeName;

  Archetype({
    required this.id,
    required this.archetypeName,
  });

  Archetype.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    archetypeName = json['archetype_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['archetype_name'] = archetypeName;
    return data;
  }
}
