import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF4A148C);

const List<Color> _colorThemes = [
  _customColor,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
];

class AppTheme {
  final int selectedColor;

  AppTheme({required this.selectedColor})
    : assert(
        selectedColor >= 0 && selectedColor < _colorThemes.length,
        'selectedColor must be between 0 and ${_colorThemes.length - 1}',
      );

  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
    );
  }
}
