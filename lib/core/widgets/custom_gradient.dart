import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  const CustomGradient({
    super.key,
    required this.widget,
    required this.gradient,
    required AppBar child,
  });

  final Widget widget;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: widget,
    );
  }
}
