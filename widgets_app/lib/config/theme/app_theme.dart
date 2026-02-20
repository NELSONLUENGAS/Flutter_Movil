import 'package:flutter/material.dart';

const List<Color> colorList = [
  Color(0xFF000000),
  Color(0xFF1B1B1B),
  Color(0xFF333333),
  Color(0xFF4D4D4D),
  Color(0xFF666666),
  Color(0xFF808080),
  Color(0xFF999999),
  Color(0xFFB3B3B3),
  Color(0xFFCCCCCC),
  Color(0xFFE6E6E6),
  Color(0xFFFFFFFF),
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
    : assert(
        selectedColor >= 0 &&
            selectedColor <
                colorList.length,
        'Selected color must be a valid index in the color list.',
      );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed:
        colorList[selectedColor],
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
  );
}
