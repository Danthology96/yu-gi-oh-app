import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';

/// Abstract class for the card repository, which will be implemented by the infrastructure layer.
abstract class CardRepository {
  /// Get all cards from the API.
  Future<List<YuGiOhCard>?> getAllCards();

  /// Get a list of archetypes.
  Future<List<Archetype>?> getArchetypes();

  /// Get a card by its archetype.
  Future<List<YuGiOhCard>?> getByArchetype({required String archetype});

  /// Get a card by its name similarities.
  Future<List<YuGiOhCard>?> getByMatchName({required String name});
}
