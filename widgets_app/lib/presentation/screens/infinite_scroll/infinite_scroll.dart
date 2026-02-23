import 'package:flutter/material.dart';

class InfiniteScrollScreen
    extends StatelessWidget {
  static const name = 'infinite_scroll';
  static const route =
      '/infinite-scroll';

  const InfiniteScrollScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Infinite Scroll Screen',
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
