import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yu_gi_oh_app/config/theme/constants/environment.dart';
import 'package:yu_gi_oh_app/domain/entities/yugioh_card.dart';
import 'package:yu_gi_oh_app/infrastructure/datasources/yugioh_db_datasource_impl.dart';

/// Test file for the Cards API
void main() {
  /// Test group for the endpoints of the Cards API
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiURL,
  ));
  group('Cards API test', () {
    /// Test for the endpoint that returns all cards and their information
    test('Get all cards and maps as YuGiOhCard', () async {
      final response = await dio.get(
        '/cardinfo.php',
      );
      final cards = jsonToYuGiOhCards(response.data);
      expect(cards, isA<List<YuGiOhCard>>());
    });

    /// Test for the endpoint that returns all cards and their information by archetype
    test('Get all cards by archetype and maps as YuGiOhCard', () async {
      final response = await dio.get(
        '/cardinfo.php',
        queryParameters: {
          'archetype': 'Crystron',
        },
      );
      final cards = jsonToYuGiOhCards(response.data);
      expect(cards, isA<List<YuGiOhCard>>());
    });

    /// test that checks if the banned cards are not in the list of cards
    test('Get all cards and check if banned cards are not in the list',
        () async {
      final response = await dio.get(
        '/cardinfo.php',
      );
      final cards = jsonToYuGiOhCards(response.data);

      /// the jsonToYuGiOhCards function returns a list of YuGiOhCard objects
      /// that should'nt have any banned cards
      final bannedCards =
          cards?.where((element) => element.banlistInfo != null);
      expect(bannedCards, isEmpty);
    });
  });
}
