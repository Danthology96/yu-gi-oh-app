import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';
import 'package:yu_gi_oh_app/infrastructure/repositories/yugioh_db_repository_impl.dart';
import 'package:yu_gi_oh_app/presentation/providers/cards_repository_provider.dart';

/// Provider for the cards repository. It will be used to provide the repository to the UI layer.
final allCardsProvider =
    StateNotifierProvider<CardsNotifier, List<YuGiOhCard>>((ref) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardsNotifier(repository: cardsRepository);
});

/// Provider for the archetypes repository. It will be used to provide the repository to the UI layer.
final archetypesProvider =
    StateNotifierProvider<ArchetypesNotifier, List<Archetype>>((ref) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return ArchetypesNotifier(repository: cardsRepository);
});

/// Card notifier class that will be used to notify the UI layer about the cards state.
class CardsNotifier extends StateNotifier<List<YuGiOhCard>> {
  CardsNotifier({required this.repository}) : super([]);

  YuGiOhDbRepositoryImpl repository;

  bool isLoading = false;

  Future<void> fetchCards() async {
    if (isLoading) return;
    isLoading = true;

    final cards = await repository.getAllCards();
    if (cards == null) return;

    state = [...state, ...cards];
    await Future.delayed(const Duration(milliseconds: 400));
    isLoading = false;
  }
}

/// Archetypes notifier class that will be used to notify the UI layer about the archetypes state.
class ArchetypesNotifier extends StateNotifier<List<Archetype>> {
  ArchetypesNotifier({required this.repository}) : super([]);

  YuGiOhDbRepositoryImpl repository;

  bool isLoading = false;

  Future<void> fetchArchetypes() async {
    if (isLoading) return;
    isLoading = true;

    final archetypes = await repository.getArchetypes();
    if (archetypes == null) return;

    state = [...state, ...archetypes];
    await Future.delayed(const Duration(milliseconds: 400));
    isLoading = false;
  }
}
