import 'package:flutter/material.dart';

class CardsScreen
    extends StatelessWidget {
  const CardsScreen({super.key});

  static const name = 'cards';
  static const route = '/cards';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cards Screen',
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
              Icons.credit_card_rounded,
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
              'Aquí verás ejemplos de tarjetas',
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
