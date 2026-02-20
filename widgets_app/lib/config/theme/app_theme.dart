import 'package:flutter/material.dart';

const List<Color> colorList = [
  Colors.blueGrey,
  Colors.indigo,
  Colors.purple,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
  Colors.cyan,
  Colors.amber,
  Colors.lightGreen,
  Colors.brown,
  Colors.blue,
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
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        height: 1.4,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
