import 'package:flutter/material.dart';

class Astronaut {
  Offset position;
  Size size;
  double velocityY;

  Astronaut({required this.position, required this.size, this.velocityY = 0});

  Rect getRect() {
    return Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
  }
}
