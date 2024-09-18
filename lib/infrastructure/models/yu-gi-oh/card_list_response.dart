import 'dart:convert';

import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';

class CardListResponse {
  final List<YuGiOhCard>? data;

  CardListResponse({
    this.data,
  });

  factory CardListResponse.fromJson(String str) =>
      CardListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardListResponse.fromMap(Map<String, dynamic> json) =>
      CardListResponse(
        data: json["data"] == null
            ? []
            : List<YuGiOhCard>.from(
                json["data"]!.map((x) => YuGiOhCard.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}
