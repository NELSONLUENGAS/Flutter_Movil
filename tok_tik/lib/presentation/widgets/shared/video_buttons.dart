import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tok_tik/config/helpers/human_formats.dart';

class VideoButtons extends StatelessWidget {
  const VideoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Custom Butons
        _CustomIconButton(
          value: 15257452,
          icon: Icons.favorite,
          iconColor: Colors.redAccent,
          onPressed: () {},
        ),
        _CustomIconButton(
          value: 1000,
          icon: Icons.remove_red_eye,
          onPressed: () {},
        ),
        SpinPerfect(
          infinite: true,
          duration: const Duration(seconds: 5),
          child: _CustomIconButton(
            value: 0,
            icon: Icons.play_circle_outline,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final double value;
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const _CustomIconButton({
    required this.value,
    required this.icon,
    required this.onPressed,
    iconColor,
  }) : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color, size: 30),
          color: color,
          onPressed: onPressed,
        ),
        value > 0
            ? Text(HumanFormats.humanReadableNumber(value))
            : SizedBox.shrink(),
      ],
    );
  }
}
