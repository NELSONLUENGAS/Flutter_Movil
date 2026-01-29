import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int clickCount = 0;
  bool get isDisable => clickCount == 0;
  bool get canReset => clickCount > 0;

  void increment() {
    setState(() {
      clickCount++;
    });
  }

  void decrement() {
    setState(() {
      if (clickCount > 0) {
        clickCount--;
      }
    });
  }

  Future<void> resetWithConfirmation(BuildContext context) async {
    final bool confirm =
        await showAdaptiveDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog.adaptive(
            title: const Text('Reiniciar contador'),
            content: Text(
              'Vas a reiniciar el contador.\n'
              'Valor actual: $clickCount\n\n'
              '¿Deseas continuar?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirm) return;

    setState(() {
      clickCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Counter Screen')),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: canReset ? () => resetWithConfirmation(context) : null,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                '$clickCount',
                key: ValueKey(clickCount),
                style: const TextStyle(
                  fontSize: 160,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Click${clickCount == 1 ? '' : 's'}',
              key: Key('clicks_text'),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFloatingActionButton(
            key: const Key('increment_button'),
            icon: Icons.plus_one,
            onPressed: increment,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Colors.teal.shade900,
          ),
          const SizedBox(height: 10),
          CustomFloatingActionButton(
            key: const Key('decrement_button'),
            icon: Icons.exposure_minus_1,
            onPressed: decrement,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Colors.teal.shade900,
            isDisabled: isDisable,
          ),
          const SizedBox(height: 10),
          CustomFloatingActionButton(
            key: const Key('reset_button'),
            icon: Icons.refresh,
            onPressed: canReset ? () => resetWithConfirmation(context) : () {},
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Colors.white,
            isDisabled: !canReset,
          ),
        ],
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isDisabled;

  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isDisabled ? null : onPressed,
      enableFeedback: true,
      elevation: 5,
      backgroundColor: isDisabled ? Colors.grey.shade400 : backgroundColor,
      foregroundColor: isDisabled ? Colors.black38 : foregroundColor,
      shape: const CircleBorder(),
      child: Icon(icon),
    );
  }
}
