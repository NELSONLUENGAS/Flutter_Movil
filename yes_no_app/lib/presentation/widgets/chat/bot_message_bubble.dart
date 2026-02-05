import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class BotMessageBubble extends StatelessWidget {
  final Message message;

  const BotMessageBubble({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(message.text, style: TextStyle(color: Colors.white)),
        ),
        message.imageUrl != null
            ? _ImageBubble(message.imageUrl!)
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl,
        width: size.width * 0.6,
        height: size.height * 0.2,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            width: size.width * 0.6,
            height: size.height * 0.2,
            padding: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Icon(
                  Icons.image_outlined,
                  size: 60,
                  color: Colors.grey.withOpacity(0.4),
                ),
                Positioned(
                  bottom: 0,
                  child: Text(
                    'Loading image...',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
