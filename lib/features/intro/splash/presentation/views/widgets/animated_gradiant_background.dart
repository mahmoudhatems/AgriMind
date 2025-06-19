import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/colors.dart';

class AnimatedGradientBackground extends StatelessWidget {
  final Animation<Alignment> animatedAlignment;
  final Widget child;

  const AnimatedGradientBackground({
    super.key,
    required this.animatedAlignment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animatedAlignment,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: animatedAlignment.value,
              end: Alignment.bottomRight,
              colors: [
                   Colors.white.withValues( alpha:  0.3),
                ColorsManager.mainBlueGreen.withValues( alpha: 0.25),
             
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
