import 'dart:math';
import 'package:flutter/material.dart';

// ── CustomClipper：用于 ClipPath，比如裁头像 ──────────────────
class SineCircleClipper extends CustomClipper<Path> {
  final double amplitude;
  final int frequency;
  final double rotationDeg;

  const SineCircleClipper({
    this.amplitude = 10,
    this.frequency = 8,
    this.rotationDeg = 0,
  });

  @override
  Path getClip(Size size) {
    return _buildSinePath(size);
  }

  @override
  bool shouldReclip(SineCircleClipper old) =>
      old.amplitude != amplitude ||
      old.frequency != frequency ||
      old.rotationDeg != rotationDeg;

  Path _buildSinePath(Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = min(cx, cy) - amplitude;
    final rotRad = rotationDeg * pi / 180;
    final path = Path();
    const steps = 720;

    for (int i = 0; i <= steps; i++) {
      final t = (i / steps) * 2 * pi;
      final rr = r + amplitude * sin(frequency * t);
      final angle = t + rotRad;
      final x = cx + rr * cos(angle);
      final y = cy + rr * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }
}

// ── CustomPainter：stroke / fill 模式 ────────────────────────
class SineCirclePainter extends CustomPainter {
  final double amplitude;
  final int frequency;
  final double rotationDeg;
  final Color color;
  final bool strokeOnly;
  final double strokeWidth;

  const SineCirclePainter({
    this.amplitude = 10,
    this.frequency = 8,
    this.rotationDeg = 0,
    this.color = Colors.blue,
    this.strokeOnly = false,
    this.strokeWidth = 2.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = SineCircleClipper(
      amplitude: amplitude,
      frequency: frequency,
      rotationDeg: rotationDeg,
    ).getClip(size); // 复用同一个路径逻辑

    final paint = Paint()..color = color;
    if (strokeOnly) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
    } else {
      paint.style = PaintingStyle.fill;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SineCirclePainter old) => true;
}
