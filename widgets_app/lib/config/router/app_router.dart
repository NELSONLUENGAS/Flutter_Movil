import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: AnimatedScreen.name,
      path: AnimatedScreen.route,
      builder: (context, state) =>
          const AnimatedScreen(),
    ),
    GoRoute(
      name: AppTutorialScreen.name,
      path: AppTutorialScreen.route,
      builder: (context, state) =>
          const AppTutorialScreen(),
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
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.route,
      builder: (context, state) =>
          const HomeScreen(),
    ),
    GoRoute(
      name: InfiniteScrollScreen.name,
      path: InfiniteScrollScreen.route,
      builder: (context, state) =>
          const InfiniteScrollScreen(),
    ),
    GoRoute(
      name: ProgressScreen.name,
      path: ProgressScreen.route,
      builder: (context, state) =>
          const ProgressScreen(),
    ),
    GoRoute(
      name: SnackbarScreen.name,
      path: SnackbarScreen.route,
      builder: (context, state) =>
          const SnackbarScreen(),
    ),
    GoRoute(
      name: UiControlsScreen.name,
      path: UiControlsScreen.route,
      builder: (context, state) =>
          const UiControlsScreen(),
    ),
  ],
);
