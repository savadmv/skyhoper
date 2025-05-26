import 'package:flutter/material.dart';

import 'widgets/game_view.dart';

void main() {
  runApp(const SpaceHopperApp());
}

class SpaceHopperApp extends StatelessWidget {
  const SpaceHopperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Space Hopper', debugShowCheckedModeBanner: false, home: Scaffold(body: GameView()));
  }
}
