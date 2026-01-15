import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnotherButton extends StatelessWidget {
  final bool isLoading;
  final ColorScheme colorScheme;
  final VoidCallback onPressed;

  const AnotherButton({
    super.key,
    required this.isLoading,
    required this.colorScheme,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
          data: Theme.of(context).copyWith(colorScheme: colorScheme),
          child: Semantics(
            label: 'Button to get another image',
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              child: const Text('Another'),
            ),
          ),
        )
        .animate(target: isLoading ? 0 : 1)
        .fade(duration: 200.ms)
        .moveY(begin: 10, end: 0, duration: 200.ms);
  }
}
