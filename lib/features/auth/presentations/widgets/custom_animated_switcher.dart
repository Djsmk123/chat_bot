import 'package:flutter/material.dart';

class AnimatedSwitchSlideIn extends StatelessWidget {
  final Widget child;
  final ValueKey? valueKey;
  const AnimatedSwitchSlideIn({super.key, required this.child, this.valueKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      child: SizedBox(key: valueKey, child: child),
    );
  }
}
