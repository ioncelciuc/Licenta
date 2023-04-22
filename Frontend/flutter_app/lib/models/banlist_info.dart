import 'package:hive/hive.dart';

part 'banlist_info.g.dart';

@HiveType(typeId: 5)
class BanlistInfo {
  @HiveField(0)
  String? banTcg;

  @HiveField(1)
  String? banOcg;

  BanlistInfo({this.banTcg, this.banOcg});

  BanlistInfo.fromJson(Map<String, dynamic> json) {
    banTcg = json['ban_tcg'];
    banOcg = json['ban_ocg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ban_tcg'] = banTcg;
    data['ban_ocg'] = banOcg;
    return data;
  }
}
