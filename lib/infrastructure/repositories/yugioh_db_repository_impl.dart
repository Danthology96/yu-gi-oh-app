import 'package:yu_gi_oh_app/domain/datasources/card_datasource.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/domain/repositories/card_repository.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';

/// Implementation of the card repository. It will be used to interact with the API.
class YuGiOhDbRepositoryImpl extends CardRepository {
  final CardDatasource cardDataSource;

  YuGiOhDbRepositoryImpl(this.cardDataSource);

  @override
  Future<List<YuGiOhCard>?> getAllCards() async {
    return await cardDataSource.getAllCards();
  }

  @override
  Future<List<YuGiOhCard>?> getCardsByArchetype(
      {required String archetype}) async {
    return await cardDataSource.getCardsByArchetype(archetype: archetype);
  }

  @override
  Future<List<YuGiOhCard>?> getCardsByMatchName({required String name}) async {
    return await cardDataSource.getCardsByMatchName(name: name);
  }

  @override
  Future<List<Archetype>?> getArchetypes() async {
    return await cardDataSource.getArchetypes();
  }

  @override
  Future<YuGiOhCard?> getCardById(int id) async {
    return await cardDataSource.getCardById(id);
  }
}
