import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _fxPlayer = AudioPlayer();

  Future<void> playBackgroundMusic({int track = 1}) async {
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgmPlayer.setVolume(0.4);
    String path = track == 2 ? 'audio/background02.flac' : 'audio/background.wav';
    await _bgmPlayer.play(AssetSource(path));
  }

  Future<void> stopBackgroundMusic() async {
    await _bgmPlayer.stop();
  }

  Future<void> playJump() async {
    await _fxPlayer.play(AssetSource('audio/jump.wav'), volume: 1.0);
  }

  Future<void> playGameOver() async {
    await _fxPlayer.play(AssetSource('audio/game_over.wav'), volume: 1.0);
  }

  Future<void> playPoint() async {
    await _fxPlayer.play(AssetSource('audio/tick.wav'), volume: 0.8);
  }
}
