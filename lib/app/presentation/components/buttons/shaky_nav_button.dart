import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShakyNavButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final void Function() onPressed;

  const ShakyNavButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: Row(
        children: [
          Text(text),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    )
    .animate(target: disabled ? 0 : 1)
    .shimmer(delay: 400.ms, duration: 1000.ms)
    .shake(hz: 4, curve: Curves.linearToEaseOut);
  }
}
