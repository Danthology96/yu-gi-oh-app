import 'package:yu_gi_oh_app/domain/datasources/card_datasource.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/domain/repositories/card_repository.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';

class YuGiOhDbRepositoryImpl extends CardRepository {
  final CardDatasource cardDataSource;

  YuGiOhDbRepositoryImpl(this.cardDataSource);

  @override
  Future<List<YuGiOhCard?>?> getAllCards() async {
    return await cardDataSource.getAllCards();
  }

  @override
  Future<List<YuGiOhCard?>?> getByArchetype({required String archetype}) async {
    return await cardDataSource.getByArchetype(archetype: archetype);
  }

  @override
  Future<List<YuGiOhCard?>?> getByMatchName({required String name}) async {
    return await cardDataSource.getByMatchName(name: name);
  }

  @override
  Future<List<Archetype?>?> getArchetypes() async {
    return await cardDataSource.getArchetypes();
  }
}
