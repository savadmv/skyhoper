import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sky_hopper_fun_widget/services/audio_service.dart';
import '../controllers/game_controller.dart';
import 'starfield_background.dart';
import 'astronaut_widget.dart';
import 'obstacle_widget.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with SingleTickerProviderStateMixin {
  late GameController _gameController;

  @override
  void initState() {
    super.initState();
    _gameController = GameController(this);

    AudioService().playBackgroundMusic(track: 1);
  }

  @override
  void dispose() {
    // Start background music
    
    _gameController.dispose();
    AudioService().stopBackgroundMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameController>.value(
      value: _gameController,
      child: Consumer<GameController>(
        builder: (context, game, child) {
          return GestureDetector(
            onTap: () {
              if (game.isGameOver) {
                game.restart();
              } else {
                game.jump();
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                const StarfieldBackground(),
               ...game.obstacles.map(
                  (obs) => ObstacleWidget(
                    position: obs.position,
                    size: obs.size,
                    assetPath: obs.assetPath, // <--- Pass the PNG
                  ),
                ),
                AstronautWidget(position: game.astronaut.position, size: game.astronaut.size),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Text('Score: ${game.score}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 3, color: Colors.black)])),
                ),
                if (game.isGameOver)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(12)),
                      child: const Text('Game Over\nTap to restart', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
