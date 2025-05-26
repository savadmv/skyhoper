import 'package:flutter/material.dart';

class ObstacleWidget extends StatelessWidget {
  final Offset position;
  final Size size;
  final String assetPath;

  const ObstacleWidget({required this.position, required this.size, required this.assetPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(left: position.dx, top: position.dy, child: SizedBox(width: size.width, height: size.height, child: Image.asset(assetPath, fit: BoxFit.contain)));
  }
}

