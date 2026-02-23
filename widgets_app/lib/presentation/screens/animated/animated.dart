import 'package:flutter/material.dart';

class AnimatedScreen
    extends StatelessWidget {
  static const name = 'animated';
  static const route = '/animated';

  const AnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animated Screen',
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
