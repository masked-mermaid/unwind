import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: 
        // Colors.grey.shade400,
        Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiary,
            offset: const Offset(5, 5),
            blurRadius: 15,
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.secondaryContainer,
            offset: const Offset(-5, -5),
            blurRadius: 15,
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: child,
    );
  }
}
