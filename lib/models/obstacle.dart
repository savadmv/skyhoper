import 'package:flutter/material.dart';
class Obstacle {
  Offset position;
  Size size;
  bool passed = false;
  String assetPath; // <--- NEW

  Obstacle({
    required this.position,
    required this.size,
    required this.assetPath, // <--- NEW
  });

  Rect getRect() {
    return Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
  }
}
