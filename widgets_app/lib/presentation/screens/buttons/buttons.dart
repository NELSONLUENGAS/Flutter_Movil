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
      body: _ButtonsView(
        colors: colors,
      ),
    );
  }
}

class _ButtonsView
    extends StatelessWidget {
  const _ButtonsView({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding:
            const EdgeInsetsGeometry.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
        child: Wrap(
          alignment:
              WrapAlignment.center,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Elevated Button',
              ),
            ),
            ElevatedButton(
              onPressed: null,
              child: const Text(
                'Elevated Button disabled',
              ),
            ),
            ElevatedButton.icon(
              label: const Text(
                'Elevatered Icon Button',
              ),
              onPressed: () {},
              icon: const Icon(
                Icons
                    .rocket_launch_outlined,
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Outlined Button',
              ),
            ),
            OutlinedButton.icon(
              label: const Text(
                'Outlined Icon Button',
              ),
              onPressed: () {},
              icon: const Icon(
                Icons
                    .rocket_launch_outlined,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text(
                'Filled Button',
              ),
            ),
            FilledButton.icon(
              onPressed: () {},
              label: const Text(
                'Filled Icon Button',
              ),
              icon: Icon(
                Icons
                    .verified_user_rounded,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Text Button',
              ),
            ),
            TextButton.icon(
              label: const Text(
                'Text Icon Button',
              ),
              onPressed: () {},
              icon: const Icon(
                Icons
                    .rocket_launch_outlined,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons
                    .rocket_launch_rounded,
              ),
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(
                      colors.primary
                          .withValues(
                            alpha: 0.1,
                          ),
                    ),
                foregroundColor:
                    WidgetStateProperty.all(
                      colors.primary,
                    ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                          8,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
