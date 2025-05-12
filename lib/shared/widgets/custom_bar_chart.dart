import 'package:flutter/material.dart';

class CustomBarChart extends StatefulWidget {
  final double entradas;
  final double saidas;

  const CustomBarChart({
    super.key,
    required this.entradas,
    required this.saidas,
  });

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _BarChartPainter(
            entradas: widget.entradas,
            saidas: widget.saidas,
            animationValue: _animation.value,
          ),
          child: const SizedBox(
            height: 200,
            width: double.infinity,
          ),
        );
      },
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final double entradas;
  final double saidas;
  final double animationValue;

  _BarChartPainter({
    required this.entradas,
    required this.saidas,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barPaintEntradas = Paint()..color = Colors.green;
    final barPaintSaidas = Paint()..color = Colors.red;

    final barShadow = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final barWidth = size.width / 4;
    final maxValue =
        (entradas > saidas ? entradas : saidas).clamp(1, double.infinity);

    final barHeightEntradas =
        (entradas / maxValue) * size.height * animationValue;
    final barHeightSaidas = (saidas / maxValue) * size.height * animationValue;

    final entradaOffsetX = size.width / 4 - barWidth / 2;
    final saidaOffsetX = 3 * size.width / 4 - barWidth / 2;

    // 🎯 Desenhar grade de fundo
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;
    const step = 40.0;
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 🎯 Desenhar sombras
    canvas.drawRect(
      Rect.fromLTWH(entradaOffsetX, size.height - barHeightEntradas, barWidth,
          barHeightEntradas),
      barShadow,
    );
    canvas.drawRect(
      Rect.fromLTWH(saidaOffsetX, size.height - barHeightSaidas, barWidth,
          barHeightSaidas),
      barShadow,
    );

    // 🎯 Desenhar barras
    canvas.drawRect(
      Rect.fromLTWH(entradaOffsetX, size.height - barHeightEntradas, barWidth,
          barHeightEntradas),
      barPaintEntradas,
    );
    canvas.drawRect(
      Rect.fromLTWH(saidaOffsetX, size.height - barHeightSaidas, barWidth,
          barHeightSaidas),
      barPaintSaidas,
    );

    // 🎯 Desenhar valores em cima das barras
    final entradasValue = (entradas * animationValue).toInt();
    textPainter.text = TextSpan(
      text: 'R\$ $entradasValue',
      style: const TextStyle(
        color: Colors.green,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(entradaOffsetX + barWidth / 2 - textPainter.width / 2,
          size.height - barHeightEntradas - 24),
    );

    final saidasValue = (saidas * animationValue).toInt();
    textPainter.text = TextSpan(
      text: 'R\$ $saidasValue',
      style: const TextStyle(
        color: Colors.red,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(saidaOffsetX + barWidth / 2 - textPainter.width / 2,
          size.height - barHeightSaidas - 24),
    );
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.entradas != entradas ||
        oldDelegate.saidas != saidas;
  }
}
