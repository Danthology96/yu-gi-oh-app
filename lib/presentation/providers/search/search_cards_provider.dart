import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/domain/repositories/card_repository.dart';
import 'package:yu_gi_oh_app/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedCardsProvider =
    StateNotifierProvider<SearchedCardsNotifier, List<YuGiOhCard>>((ref) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);

  return SearchedCardsNotifier(cardsRepository: cardsRepository, ref: ref);
});

class SearchedCardsNotifier extends StateNotifier<List<YuGiOhCard>> {
  final Ref ref;
  final CardRepository cardsRepository;

  SearchedCardsNotifier({
    required this.ref,
    required this.cardsRepository,
  }) : super([]);

  Future<List<YuGiOhCard>> cardsByArchetypeQuery(String query) async {
    final List<YuGiOhCard> cards =
        await cardsRepository.getCardsByArchetype(archetype: query) ?? [];
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = cards;
    return cards;
  }

  Future<List<YuGiOhCard>> cardsByNameQuery(String query) async {
    final List<YuGiOhCard> cards =
        await cardsRepository.getCardsByMatchName(name: query) ?? [];
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = cards;
    return cards;
  }
}
