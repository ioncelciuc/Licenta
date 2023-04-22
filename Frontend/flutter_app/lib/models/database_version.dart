import 'package:hive/hive.dart';

part 'database_version.g.dart';

@HiveType(typeId: 0)
class DatabaseVersion extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? databaseVersion;

  @HiveField(2)
  String? lastUpdate;

  DatabaseVersion({
    this.id,
    this.databaseVersion,
    this.lastUpdate,
  });

  DatabaseVersion.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    databaseVersion = json['database_version'];
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['database_version'] = databaseVersion;
    data['last_update'] = lastUpdate;
    return data;
  }
}
