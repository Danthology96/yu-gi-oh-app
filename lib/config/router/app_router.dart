import 'package:go_router/go_router.dart';
import 'package:yu_gi_oh_app/presentation/pages/home_page.dart';

final appRouter = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
    path: HomePage.path,
    name: HomePage.name,
  ),
  GoRoute(
    path: '/',
    redirect: (_, __) => HomePage.path,
  ),
]);
