import 'dart:math';
import 'package:flutter/material.dart';

class StarfieldBackground extends StatefulWidget {
  const StarfieldBackground({Key? key}) : super(key: key);

  @override
  State<StarfieldBackground> createState() => _StarfieldBackgroundState();
}

class _StarfieldBackgroundState extends State<StarfieldBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> stars;
  final int starCount = 80;
  final double speed = 0.7;

  @override
  void initState() {
    super.initState();
    stars = [];
    _controller =
        AnimationController(vsync: this, duration: const Duration(days: 1))
          ..addListener(() {
            setState(() {
              // Animate stars to the left
              for (var i = 0; i < stars.length; i++) {
                final star = stars[i];
                stars[i] = Offset(star.dx - speed, star.dy);
              }
            });
          })
          ..forward();
  }

  void _ensureStarsInitialized(Size size) {
    if (stars.length != starCount || stars.any((s) => s.dx < 0)) {
      stars = List.generate(starCount, (_) => Offset(Random().nextDouble() * size.width, Random().nextDouble() * size.height));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _ensureStarsInitialized(size);
    return SizedBox.expand(child: CustomPaint(painter: _StarfieldPainter(stars)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _StarfieldPainter extends CustomPainter {
  final List<Offset> stars;
  _StarfieldPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    // Paint the night sky
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.black);
    final paint = Paint()..color = Colors.white.withOpacity(0.8);
    for (final star in stars) {
      canvas.drawCircle(star, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter oldDelegate) => true;
}
