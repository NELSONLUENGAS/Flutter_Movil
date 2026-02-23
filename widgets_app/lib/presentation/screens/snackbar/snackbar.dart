import 'package:flutter/material.dart';

class SnackbarScreen
    extends StatelessWidget {
  static const name = 'snackbar';
  static const route = '/snackbar';

  const SnackbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(
      context,
    ).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Snackbar Screen',
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
