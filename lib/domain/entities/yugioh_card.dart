import 'dart:convert';

import 'package:yu_gi_oh_app/domain/enums/enums.dart';
import 'package:yu_gi_oh_app/infrastructure/models/models.dart';

class YuGiOhCard {
  final int? id;
  final String? name;
  final Type? type;
  final HumanReadableCardType? humanReadableCardType;
  final FrameType? frameType;
  final String? desc;
  final Race? race;
  final String? archetype;
  final String? ygoprodeckUrl;
  final List<CardSet>? cardSets;
  final List<CardImage>? cardImages;
  final List<CardPrice>? cardPrices;
  final List<Typeline>? typeline;
  final int? atk;
  final int? def;
  final int? level;
  final Attribute? attribute;
  final String? pendDesc;
  final String? monsterDesc;
  final int? scale;
  final int? linkval;
  final List<Linkmarker>? linkmarkers;
  final BanlistInfo? banlistInfo;

  YuGiOhCard({
    this.id,
    this.name,
    this.type,
    this.humanReadableCardType,
    this.frameType,
    this.desc,
    this.race,
    this.archetype,
    this.ygoprodeckUrl,
    this.cardSets,
    this.cardImages,
    this.cardPrices,
    this.typeline,
    this.atk,
    this.def,
    this.level,
    this.attribute,
    this.pendDesc,
    this.monsterDesc,
    this.scale,
    this.linkval,
    this.linkmarkers,
    this.banlistInfo,
  });

  factory YuGiOhCard.fromJson(String str) =>
      YuGiOhCard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory YuGiOhCard.fromMap(Map<String, dynamic> json) => YuGiOhCard(
        id: json["id"],
        name: json["name"],
        type: typeValues.map[json["type"]],
        humanReadableCardType:
            humanReadableCardTypeValues.map[json["humanReadableCardType"]],
        frameType: frameTypeValues.map[json["frameType"]],
        desc: json["desc"],
        race: raceValues.map[json["race"]],
        archetype: json["archetype"],
        ygoprodeckUrl: json["ygoprodeck_url"],
        cardSets: json["card_sets"] == null
            ? []
            : List<CardSet>.from(
                json["card_sets"].map((x) => CardSet.fromMap(x))),
        cardImages: json["card_images"] == null
            ? []
            : List<CardImage>.from(
                json["card_images"].map((x) => CardImage.fromMap(x))),
        cardPrices: json["card_prices"] == null
            ? []
            : List<CardPrice>.from(
                json["card_prices"].map((x) => CardPrice.fromMap(x))),
        typeline: json["typeline"] == null
            ? []
            : List<Typeline>.from(
                json["typeline"].map((x) => typelineValues.map[x])),
        atk: json["atk"],
        def: json["def"],
        level: json["level"],
        attribute: attributeValues.map[json["attribute"]],
        pendDesc: json["pend_desc"],
        monsterDesc: json["monster_desc"],
        scale: json["scale"],
        linkval: json["linkval"],
        linkmarkers: json["linkmarkers"] == null
            ? []
            : List<Linkmarker>.from(
                json["linkmarkers"].map((x) => linkmarkerValues.map[x])),
        banlistInfo: json["banlist_info"] == null
            ? null
            : BanlistInfo.fromMap(json["banlist_info"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": typeValues.reverse[type],
        "humanReadableCardType":
            humanReadableCardTypeValues.reverse[humanReadableCardType],
        "frameType": frameTypeValues.reverse[frameType],
        "desc": desc,
        "race": raceValues.reverse[race],
        "archetype": archetype,
        "ygoprodeck_url": ygoprodeckUrl,
        "card_sets": cardSets == null
            ? []
            : List<dynamic>.from(cardSets!.map((x) => x.toMap())),
        "card_images": cardImages == null
            ? []
            : List<dynamic>.from(cardImages!.map((x) => x.toMap())),
        "card_prices": cardPrices == null
            ? []
            : List<dynamic>.from(cardPrices!.map((x) => x.toMap())),
        "typeline": typeline == null
            ? []
            : List<dynamic>.from(
                typeline!.map((x) => typelineValues.reverse[x])),
        "atk": atk,
        "def": def,
        "level": level,
        "attribute": attributeValues.reverse[attribute],
        "pend_desc": pendDesc,
        "monster_desc": monsterDesc,
        "scale": scale,
        "linkval": linkval,
        "linkmarkers": linkmarkers == null
            ? []
            : List<dynamic>.from(
                linkmarkers!.map((x) => linkmarkerValues.reverse[x])),
        "banlist_info": banlistInfo?.toMap(),
      };
}
