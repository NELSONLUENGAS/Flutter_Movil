import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class UserMessageBubble extends StatelessWidget {
  final Message message;

  const UserMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(message.text, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
