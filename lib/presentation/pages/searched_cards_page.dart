import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yu_gi_oh_app/presentation/pages/pages.dart';
import 'package:yu_gi_oh_app/presentation/providers/providers.dart';
import 'package:yu_gi_oh_app/presentation/widgets/search_card_item.dart';

class SearchedCardsPage extends ConsumerStatefulWidget {
  const SearchedCardsPage({
    super.key,
    required this.archetypeName,
  });

  static const name = 'searched-cards';
  static const path = name;

  final String archetypeName;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchedCardsPageState();
}

class _SearchedCardsPageState extends ConsumerState<SearchedCardsPage> {
  @override
  void initState() {
    super.initState();

    ref
        .read(archetypeCardsProvider.notifier)
        .fetchByArchetype(widget.archetypeName);
  }

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(archetypeCardsProvider);

    if (cards.isEmpty) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.archetypeName),
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return SearchCardItem(
            card: cards[index],
            onCardSelected: (context, card) {
              context.push(
                  '${HomePage.path}/${CardDetailPage.path}/${cards[index].id}');
            },
          );
        },
      ),
    );
  }
}
