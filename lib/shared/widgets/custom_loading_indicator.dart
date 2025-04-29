// lib/shared/widgets/custom_loading_indicator.dart
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const CustomLoadingIndicator({
    super.key,
    this.size = 50.0,
    this.color,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
