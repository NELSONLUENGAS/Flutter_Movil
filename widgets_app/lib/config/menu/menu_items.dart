import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

const appMenuitems = <MenuItem>[
  MenuItem(
    icon: Icons.smart_button_outlined,
    title: 'Botones',
    subTitle:
        'Explore various button styles',
    link: '/buttons',
  ),
  MenuItem(
    icon: Icons.credit_card_outlined,
    title: 'Tarjetas',
    subTitle:
        'Discover different card designs',
    link: '/cards',
  ),
];
