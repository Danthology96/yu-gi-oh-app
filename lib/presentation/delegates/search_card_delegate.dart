import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/presentation/widgets/search_card_item.dart';

/// Callback to search for cards.
typedef SearchCardsCallback = Future<List<YuGiOhCard>> Function(String query);

/// Search delegate to search for cards.
class SearchCardDelegate extends SearchDelegate<YuGiOhCard?> {
  final SearchCardsCallback searchCards;
  List<YuGiOhCard> initialCards;
  final TextStyle searchTextStyle;

  StreamController<List<YuGiOhCard>> debouncedCards =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchCardDelegate({
    required this.searchCards,
    required this.initialCards,
    required this.searchTextStyle,
  }) : super(
          searchFieldLabel: 'Buscar carta por nombre',
          searchFieldStyle: searchTextStyle,
        );

  void clearStreams() {
    debouncedCards.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.trim().isEmpty) {
        debouncedCards.add([]);
        return;
      }

      final cards = await searchCards(query);
      initialCards = cards;
      debouncedCards.add(cards);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialCards,
      stream: debouncedCards.stream,
      builder: (context, snapshot) {
        final cards = snapshot.data ?? [];

        if (cards.isEmpty) {
          return Center(
            child: Text('No se encontraron cartas con "$query"'),
          );
        }

        return ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) => SearchCardItem(
            card: cards[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}
