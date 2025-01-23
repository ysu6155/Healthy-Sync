import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget(
      {required this.widget,
        required this.gradient,

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