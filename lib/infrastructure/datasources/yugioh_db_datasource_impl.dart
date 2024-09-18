import 'package:dio/dio.dart';
import 'package:yu_gi_oh_app/config/theme/constants/environment.dart';
import 'package:yu_gi_oh_app/domain/datasources/card_datasource.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/infrastructure/models/models.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';

/// Implementation of the [CardDatasource] for the YuGiOh API.
class YugiOhDbDatasourceImpl extends CardDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiURL,
  ));

  /// Convert the JSON response to a list of YuGiOhCards.
  List<YuGiOhCard?>? _jsonToYuGiOhCards(Map<String, dynamic> json) {
    final yuGiOhresponse = CardListResponse.fromMap(json);
    final List<YuGiOhCard> cards =
        yuGiOhresponse.data == null ? [] : yuGiOhresponse.data!;
    return cards;
  }

  @override
  Future<List<YuGiOhCard?>?> getAllCards() async {
    final response = await dio.get(
      '/cardinfo.php',
    );
    return _jsonToYuGiOhCards(response.data);
  }

  @override
  Future<List<YuGiOhCard?>?> getByArchetype({required String archetype}) async {
    final response = await dio.get(
      '/cardinfo.php',
      queryParameters: {
        'archetype': archetype,
      },
    );
    return _jsonToYuGiOhCards(response.data);
  }

  @override
  Future<List<YuGiOhCard?>?> getByMatchName({required String name}) async {
    final response = await dio.get(
      '/cardinfo.php',
      queryParameters: {
        'fname': name,
      },
    );
    return _jsonToYuGiOhCards(response.data);
  }

  @override
  Future<List<Archetype?>?> getArchetypes() async {
    final response = await dio.get(
      '/archetypes.php',
    );
    final List<Archetype> archetypes =
        response.data == null ? [] : response.data!;
    return archetypes;
  }
}
