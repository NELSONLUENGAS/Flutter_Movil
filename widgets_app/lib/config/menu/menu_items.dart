import 'package:flutter/material.dart';
import 'package:widgets_app/presentation/screens/home/home_screen.dart';
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
];
