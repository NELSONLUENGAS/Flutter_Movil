import 'package:flutter/material.dart';

class AppTutorialScreen
    extends StatelessWidget {
  static const name = 'app_tutorial';
  static const route = '/app-tutorial';

  const AppTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Tutorial Screen',
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary,
                colors.secondary,
              ],
            ),
          ),
        ),
      ),
      body: Placeholder(),
    );
  }
}
