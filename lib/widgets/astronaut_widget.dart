import 'package:flutter/material.dart';

class AstronautWidget extends StatelessWidget {
  final Offset position;
  final Size size;

  const AstronautWidget({required this.position, required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(left: position.dx, top: position.dy, child: SizedBox(width: size.width, height: size.height, child: Image.asset('assets/astronaut.png',package: 'sky_hopper_fun_widget', fit: BoxFit.contain)));
  }
}
