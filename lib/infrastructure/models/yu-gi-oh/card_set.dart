import 'dart:convert';

import 'package:yu_gi_oh_app/domain/enums/enums.dart';

class CardSet {
  final String? setName;
  final String? setCode;
  final SetRarity? setRarity;
  final SetRarityCode? setRarityCode;
  final String? setPrice;

  CardSet({
    this.setName,
    this.setCode,
    this.setRarity,
    this.setRarityCode,
    this.setPrice,
  });

  factory CardSet.fromJson(String str) => CardSet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardSet.fromMap(Map<String, dynamic> json) => CardSet(
        setName: json["set_name"],
        setCode: json["set_code"],
        setRarity: setRarityValues.map[json["set_rarity"]]!,
        setRarityCode: setRarityCodeValues.map[json["set_rarity_code"]]!,
        setPrice: json["set_price"],
      );

  Map<String, dynamic> toMap() => {
        "set_name": setName,
        "set_code": setCode,
        "set_rarity": setRarityValues.reverse[setRarity],
        "set_rarity_code": setRarityCodeValues.reverse[setRarityCode],
        "set_price": setPrice,
      };
}
