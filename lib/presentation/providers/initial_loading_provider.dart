import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yu_gi_oh_app/presentation/providers/cards_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  return ref.watch(allCardsProvider).isEmpty;
});
