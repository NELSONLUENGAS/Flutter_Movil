import 'package:flutter/material.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final String name;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.name,
    required this.icon,
  });
}

const appMenuitems = <MenuItem>[
  MenuItem(
    title: 'Animated',
    subTitle:
        'Animaciones y transiciones',
    icon: Icons.animation,
    link: AnimatedScreen.route,
    name: AnimatedScreen.name,
  ),
  MenuItem(
    title: 'App Tutorial',
    subTitle: 'Tutorial de la app',
    icon: Icons.school,
    link: AppTutorialScreen.route,
    name: AppTutorialScreen.name,
  ),
  MenuItem(
    icon: Icons.smart_button_outlined,
    title: 'Botones',
    subTitle:
        'Explore various button styles',
    link: ButtonsScreen.route,
    name: ButtonsScreen.name,
  ),
  MenuItem(
    icon: Icons.credit_card_outlined,
    title: 'Tarjetas',
    subTitle:
        'Discover different card designs',
    link: CardsScreen.route,
    name: CardsScreen.name,
  ),
  MenuItem(
    title: 'Infinite Scroll',
    subTitle: 'Scroll infinito',
    icon: Icons.all_inclusive,
    link: InfiniteScrollScreen.route,
    name: InfiniteScrollScreen.name,
  ),
  MenuItem(
    title: 'Progress',
    subTitle: 'Indicadores de progreso',
    icon: Icons.hourglass_empty,
    link: ProgressScreen.route,
    name: ProgressScreen.name,
  ),
  MenuItem(
    title: 'Snackbar',
    subTitle: 'Mensajes Snackbar',
    icon: Icons.message,
    link: SnackbarScreen.route,
    name: SnackbarScreen.name,
  ),
  MenuItem(
    title: 'UI Controls',
    subTitle: 'Controles de interfaz',
    icon: Icons.tune,
    link: UiControlsScreen.route,
    name: UiControlsScreen.name,
  ),
];
