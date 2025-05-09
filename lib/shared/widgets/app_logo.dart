import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry alignment;
  final BorderRadiusGeometry? borderRadius;

  const AppLogo({
    super.key,
    this.size = 80,
    this.margin,
    this.alignment = Alignment.center,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: alignment,
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
