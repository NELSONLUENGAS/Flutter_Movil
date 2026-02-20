import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.route,
      builder: (context, state) =>
          const HomeScreen(),
    ),
    GoRoute(
      name: ButtonsScreen.name,
      path: ButtonsScreen.route,
      builder: (context, state) =>
          const ButtonsScreen(),
    ),
    GoRoute(
      name: CardsScreen.name,
      path: CardsScreen.route,
      builder: (context, state) =>
          const CardsScreen(),
    ),
  ],
);
