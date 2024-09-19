import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yu_gi_oh_app/config/theme/constants/environment.dart';
import 'package:yu_gi_oh_app/domain/datasources/card_datasource.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/archetypes.dart';
import 'package:yu_gi_oh_app/infrastructure/models/yu-gi-oh/card_list_response.dart';

/// Implementation of the [CardDatasource] for the YuGiOh API.
class YugiOhDbDatasourceImpl extends CardDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiURL,
  ));

  @override
  Future<List<YuGiOhCard>?> getAllCards() async {
    final response = await dio.get(
      '/cardinfo.php',
    );
    return jsonToYuGiOhCards(response.data);
  }

  @override
  Future<List<YuGiOhCard>?> getCardsByArchetype(
      {required String archetype}) async {
    try {
      final response = await dio.get(
        '/cardinfo.php',
        queryParameters: {
          'archetype': archetype,
        },
      );
      return jsonToYuGiOhCards(response.data);
    } catch (e) {
      // Handle the error appropriately
      debugPrint('Error fetching cards by archetype: $e');
      return null;
    }
  }

  @override
  Future<List<YuGiOhCard>?> getCardsByMatchName({required String name}) async {
    try {
      final response = await dio.get(
        '/cardinfo.php',
        queryParameters: {
          'fname': name,
        },
      );
      return jsonToYuGiOhCards(response.data);
    } catch (e) {
      // Handle the error appropriately
      debugPrint('Error fetching cards by archetype: $e');
      return null;
    }
  }

  @override
  Future<List<Archetype>?> getArchetypes() async {
    try {
      final response = await dio.get(
        '/archetypes.php',
      );
      final List<Archetype> archetypes = response.data == null
          ? []
          : (response.data as List)
              .map((item) => Archetype.fromMap(item))
              .toList();
      return archetypes;
    } catch (e) {
      // Handle the error appropriately
      debugPrint('Error fetching cards by archetype: $e');
      return null;
    }
  }

  @override
  Future<YuGiOhCard?> getCardById(int id) async {
    try {
      final response = await dio.get(
        '/cardinfo.php',
        queryParameters: {
          'id': id,
        },
      );
      final YuGiOhCard? card = response.data == null
          ? null
          : YuGiOhCard.fromMap(response.data["data"][0]);
      return card;
    } catch (e) {
      // Handle the error appropriately
      debugPrint('Error fetching cards by archetype: $e');
      return null;
    }
  }
}

/// Convert the JSON response to a list of YuGiOhCards.
List<YuGiOhCard>? jsonToYuGiOhCards(Map<String, dynamic> json) {
  final yuGiOhresponse = CardListResponse.fromMap(json);
  final List<YuGiOhCard> cards =
      yuGiOhresponse.data == null ? [] : yuGiOhresponse.data!;

  /// Filter out cards that are banned.
  final availableCards =
      cards.where((card) => card.banlistInfo == null).toList();

  return availableCards;
}
