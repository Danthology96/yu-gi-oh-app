import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';
import 'package:yu_gi_oh_app/presentation/delegates/search_archetype_delegate.dart';
import 'package:yu_gi_oh_app/presentation/delegates/search_card_delegate.dart';
import 'package:yu_gi_oh_app/presentation/pages/pages.dart';
import 'package:yu_gi_oh_app/presentation/pages/searched_cards_page.dart';
import 'package:yu_gi_oh_app/presentation/providers/providers.dart';
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
                    onPressed: () async {
                      final searchedCards = ref.read(searchedCardsProvider);
                      final searchQuery = ref.read(searchQueryProvider);
                      await showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                            MediaQuery.of(context).size.width,
                            kToolbarHeight,
                            0.0,
                            0.0,
                          ),
                          items: [
                            const PopupMenuItem(
                              value: 'name',
                              child: Text('Buscar por nombre'),
                            ),
                            const PopupMenuItem(
                              value: 'archetype',
                              child: Text('Buscar por arquetipo'),
                            ),
                          ]).then((value) {
                        if (value == null) return;
                        bool isArchetypeSearch = false;
                        if (value == 'archetype') {
                          isArchetypeSearch = true;
                        }

                        if (isArchetypeSearch) {
                          _showArchetypeSearch(
                                  searchQuery, context, textTheme, ref)
                              .then((archetype) {
                            if (archetype == null) return;

                            context.push(
                                '${HomePage.path}/${SearchedCardsPage.path}/${archetype.archetypeName}');
                          });
                        } else {
                          _showCardSearch(searchQuery, context, searchedCards,
                                  textTheme, isArchetypeSearch, ref)
                              .then((card) {
                            if (card == null) return;

                            context.push(
                                '${HomePage.path}/${CardDetailPage.path}/${card.id}');
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }

  Future<YuGiOhCard?> _showCardSearch(
      String searchQuery,
      BuildContext context,
      List<YuGiOhCard> searchedCards,
      TextTheme textTheme,
      bool isArchetypeSearch,
      WidgetRef ref) {
    return showSearch<YuGiOhCard?>(
        query: searchQuery,
        context: context,
        delegate: SearchCardDelegate(
          initialCards: searchedCards,
          searchTextStyle: textTheme.bodyLarge!,
          searchCards: isArchetypeSearch
              ? ref.read(searchedCardsProvider.notifier).cardsByArchetypeQuery
              : ref.read(searchedCardsProvider.notifier).cardsByNameQuery,
        ));
  }

  Future<Archetype?> _showArchetypeSearch(String searchQuery,
      BuildContext context, TextTheme textTheme, WidgetRef ref) async {
    return await ref
        .read(archetypesProvider.notifier)
        .fetchArchetypes()
        .then((value) {
      return showSearch<Archetype?>(
          query: searchQuery,
          context: context,
          delegate: SearchArchetypeDelegate(
            searchTextStyle: textTheme.bodyLarge!,
            initialArchetypes: value ?? [],
          ));
    });
  }
}
