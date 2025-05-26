import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sky_hopper/services/audio_service.dart';
import '../models/astronaut.dart';
import '../models/obstacle.dart';
import '../core/collision.dart';

class GameController extends ChangeNotifier {
  // Game area
  final double groundY = 500; // Y position of ground
  final double gravity = 1.0;
  final double jumpVelocity = -22;
  final double obstacleSpeed = 6;
  final double obstacleWidth = 60;
  final double obstacleHeight = 60;
  final List<String> obstacleAssets = ['assets/alien.png', 'assets/asteroid.png', 'assets/meteor.png', 'assets/satellite.png'];

  Astronaut astronaut = Astronaut(position: Offset(80, 500), size: Size(100, 100), velocityY: 0);

  List<Obstacle> obstacles = [];
  int score = 0;
  bool isGameOver = false;

  late Ticker _ticker;
  Duration _lastTick = Duration.zero;
  double _timeSinceLastObstacle = 0;

  GameController(TickerProvider tickerProvider) {
    _ticker = tickerProvider.createTicker(_onTick)..start();
  }

  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void jump() {
    if (astronaut.position.dy >= groundY) {
      astronaut.velocityY = jumpVelocity;
      AudioService().playJump(); // <-- Add this
    }
  }

  void restart() {
    astronaut.position = Offset(80, groundY);
    astronaut.velocityY = 0;
    obstacles.clear();
    score = 0;
    isGameOver = false;
    _timeSinceLastObstacle = 0;
    notifyListeners();
  }

  void _onTick(Duration elapsed) {
    double dt = (elapsed - _lastTick).inMilliseconds / 1000.0;
    if (dt > 0.05) dt = 0.016; // prevent big jump on first frame

    if (!isGameOver) {
      // Gravity/jump logic
      astronaut.velocityY += gravity;
      astronaut.position = astronaut.position.translate(0, astronaut.velocityY);

      if (astronaut.position.dy > groundY) {
        astronaut.position = Offset(astronaut.position.dx, groundY);
        astronaut.velocityY = 0;
      }

      // Move obstacles
      for (var obs in obstacles) {
        obs.position = obs.position.translate(-obstacleSpeed, 0);
      }

      // Remove offscreen obstacles
      obstacles.removeWhere((obs) => obs.position.dx + obs.size.width < 0);

      // Spawn new obstacles
      _timeSinceLastObstacle += dt;
      if (_timeSinceLastObstacle > 1.2 + Random().nextDouble()) {
        String randomAsset = obstacleAssets[Random().nextInt(obstacleAssets.length)];
        obstacles.add(
          Obstacle(
            position: Offset(420, groundY + obstacleHeight / 2 - 40),
            size: Size(obstacleWidth, obstacleHeight),
            assetPath: randomAsset, // <-- use the chosen PNG
          ),
        );
        _timeSinceLastObstacle = 0;
      }

      // Collision detection
      Rect astroRect = astronaut.getRect();
      for (var obs in obstacles) {
        if (checkCollision(astroRect, obs.getRect())) {
          isGameOver = true;
          AudioService().playGameOver(); 
        }
      }

      // Update score (passed obstacles)
      for (var obs in obstacles) {
        if (!obs.passed && obs.position.dx + obs.size.width < astronaut.position.dx) {
          obs.passed = true;
          score++;
          AudioService().playPoint();
        }
      }
    }
    _lastTick = elapsed;
    notifyListeners();
  }
}
