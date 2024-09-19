import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/presentation/providers/providers.dart';

/// This map will provide the card information to the UI layer.
/// if the card is not in the map, it will be fetched from the API.
/// if the card is already in the map, it will be provided from the map. so it will not be fetched again.
final cardInfoProvider =
    StateNotifierProvider<CardInfoNotifier, Map<String, YuGiOhCard>>((ref) {
  final cardRepository = ref.watch(cardsRepositoryProvider);
  return CardInfoNotifier(getCard: cardRepository.getCardById);
});

typedef GetCardCallback = Future<YuGiOhCard?> Function(int id);

class CardInfoNotifier extends StateNotifier<Map<String, YuGiOhCard>> {
  final GetCardCallback getCard;

  CardInfoNotifier({
    required this.getCard,
  }) : super({});

  Future<void> loadCard(String cardId) async {
    if (state[cardId.toString()] != null) return;
    final card = await getCard(int.parse(cardId));
    state = {...state, cardId.toString(): card!};
  }
}
