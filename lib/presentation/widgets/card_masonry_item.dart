import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';

class CardMasonryItem extends StatelessWidget {
  final YuGiOhCard card;

  const CardMasonryItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(card.cardImages!.first.imageUrlSmall!),
        ),
      ),
    );
  }
}
