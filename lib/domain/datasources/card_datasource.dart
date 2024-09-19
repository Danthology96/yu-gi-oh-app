import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';

/// Abstract class for the card datasource, which will be implemented by the infrastructure layer.
abstract class CardDatasource {
  /// Get all cards from the API.
  Future<List<YuGiOhCard>?> getAllCards();

  /// Get a list of archetypes.
  Future<List<Archetype>?> getArchetypes();

  /// Get a list of cards by its archetype.
  Future<List<YuGiOhCard>?> getCardsByArchetype({required String archetype});

  /// Get a card by its id.
  Future<YuGiOhCard?> getCardById(int id);

  /// Get a list of cards by its name similarities.
  Future<List<YuGiOhCard>?> getCardsByMatchName({required String name});
}
