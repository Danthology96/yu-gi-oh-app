import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';

class SearchCardItem extends StatelessWidget {
  final YuGiOhCard card;
  final Function onMovieSelected;

  const SearchCardItem(
      {super.key, required this.card, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, card);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (card.cardImages?[0].imageUrl != null)
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    card.cardImages?[0].imageUrl ?? '',
                    loadingBuilder: (context, child, loadingProgress) =>
                        FadeIn(child: child),
                  ),
                ),
              ),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(card.name ?? '', style: textStyles.titleSmall),
                  Text(
                    card.desc ?? '',
                    style: textStyles.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
