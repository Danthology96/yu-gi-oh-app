import 'dart:convert';

class CardImage {
  final int? id;
  final String? imageUrl;
  final String? imageUrlSmall;
  final String? imageUrlCropped;

  CardImage({
    this.id,
    this.imageUrl,
    this.imageUrlSmall,
    this.imageUrlCropped,
  });

  factory CardImage.fromJson(String str) => CardImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardImage.fromMap(Map<String, dynamic> json) => CardImage(
        id: json["id"],
        imageUrl: json["image_url"],
        imageUrlSmall: json["image_url_small"],
        imageUrlCropped: json["image_url_cropped"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image_url": imageUrl,
        "image_url_small": imageUrlSmall,
        "image_url_cropped": imageUrlCropped,
      };
}
