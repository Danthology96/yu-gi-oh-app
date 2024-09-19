import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/presentation/pages/card_detail_page.dart';
import 'package:yu_gi_oh_app/presentation/pages/home_page.dart';

class CardMasonryItem extends StatelessWidget {
  final YuGiOhCard card;

  const CardMasonryItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () =>
            context.push('${HomePage.path}/${CardDetailPage.path}/${card.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(card.cardImages!.first.imageUrlSmall!),
        ),
      ),
    );
  }
}
