import 'package:flutter/material.dart';

class ButtonsScreen
    extends StatelessWidget {
  const ButtonsScreen({super.key});

  static const name = 'buttons';
  static const route = '/buttons';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buttons Screen',
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
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .smart_button_rounded,
              size: 120,
              color: colors.primary
                  .withValues(
                    alpha: 0.3,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Próximamente',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    color: colors
                        .onSurface
                        .withValues(
                          alpha: 0.5,
                        ),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aquí verás ejemplos de botones',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                    color: colors
                        .onSurface
                        .withValues(
                          alpha: 0.3,
                        ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
