import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/presentation/delegates/search_card_delegate.dart';
import 'package:yu_gi_oh_app/presentation/providers/search/search_cards_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('YuGiOh', style: textTheme.titleMedium),
                IconButton(
                    onPressed: () {
                      final searchedCards = ref.read(searchedCardsProvider);
                      final searchQuery = ref.read(searchQueryProvider);

                      showSearch<YuGiOhCard?>(
                              query: searchQuery,
                              context: context,
                              delegate: SearchCardDelegate(
                                  initialCards: searchedCards,
                                  searchTextStyle: textTheme.bodyLarge!,
                                  searchCards: ref
                                      .read(searchedCardsProvider.notifier)
                                      .cardsByNameQuery))
                          .then((movie) {
                        if (movie == null) return;
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
