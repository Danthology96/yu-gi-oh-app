import 'dart:convert';

class CardPrice {
  final String? cardmarketPrice;
  final String? tcgplayerPrice;
  final String? ebayPrice;
  final String? amazonPrice;
  final String? coolstuffincPrice;

  CardPrice({
    this.cardmarketPrice,
    this.tcgplayerPrice,
    this.ebayPrice,
    this.amazonPrice,
    this.coolstuffincPrice,
  });

  factory CardPrice.fromJson(String str) => CardPrice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardPrice.fromMap(Map<String, dynamic> json) => CardPrice(
        cardmarketPrice: json["cardmarket_price"],
        tcgplayerPrice: json["tcgplayer_price"],
        ebayPrice: json["ebay_price"],
        amazonPrice: json["amazon_price"],
        coolstuffincPrice: json["coolstuffinc_price"],
      );

  Map<String, dynamic> toMap() => {
        "cardmarket_price": cardmarketPrice,
        "tcgplayer_price": tcgplayerPrice,
        "ebay_price": ebayPrice,
        "amazon_price": amazonPrice,
        "coolstuffinc_price": coolstuffincPrice,
      };
}
