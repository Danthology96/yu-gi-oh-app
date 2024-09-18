import 'dart:convert';

class Archetype {
  final String? archetypeName;

  Archetype({
    this.archetypeName,
  });

  factory Archetype.fromJson(String str) => Archetype.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Archetype.fromMap(Map<String, dynamic> json) => Archetype(
        archetypeName: json["archetype_name"],
      );

  Map<String, dynamic> toMap() => {
        "archetype_name": archetypeName,
      };
}
