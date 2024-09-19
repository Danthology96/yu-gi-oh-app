import 'dart:convert';

import 'package:yu_gi_oh_app/domain/enums/enums.dart';

class BanlistInfo {
  final Ban? banGoat;
  final Ban? banTcg;
  final Ban? banOcg;

  BanlistInfo({
    this.banGoat,
    this.banTcg,
    this.banOcg,
  });

  factory BanlistInfo.fromJson(String str) =>
      BanlistInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BanlistInfo.fromMap(Map<String, dynamic> json) => BanlistInfo(
        banGoat: banValues.map[json["ban_goat"]],
        banTcg: banValues.map[json["ban_tcg"]],
        banOcg: banValues.map[json["ban_ocg"]],
      );

  Map<String, dynamic> toMap() => {
        "ban_goat": banValues.reverse[banGoat],
        "ban_tcg": banValues.reverse[banTcg],
        "ban_ocg": banValues.reverse[banOcg],
      };
}
