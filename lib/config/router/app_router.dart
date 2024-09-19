import 'package:go_router/go_router.dart';
import 'package:yu_gi_oh_app/presentation/pages/card_detail_page.dart';
import 'package:yu_gi_oh_app/presentation/pages/home_page.dart';
import 'package:yu_gi_oh_app/presentation/pages/searched_cards_page.dart';

final appRouter = GoRouter(initialLocation: HomePage.path, routes: [
  GoRoute(
    path: HomePage.path,
    name: HomePage.name,
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: '${CardDetailPage.path}/:id',
        name: CardDetailPage.name,
        builder: (context, state) {
          final cardId = state.pathParameters['id'] ?? 'no-id';

          return CardDetailPage(cardId: cardId);
        },
      ),
      GoRoute(
        path: '${SearchedCardsPage.path}/:name',
        name: SearchedCardsPage.name,
        builder: (context, state) {
          final archetypeName = state.pathParameters['name'] ?? 'no-name';
          return SearchedCardsPage(archetypeName: archetypeName);
        },
      ),
    ],
  ),
  GoRoute(
    path: '/',
    redirect: (_, __) => HomePage.path,
  ),
]);
