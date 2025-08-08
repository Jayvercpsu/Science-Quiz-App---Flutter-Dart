import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  static Future<void> playTap() async {
    final player = AudioPlayer();
    try {
      await player.play(AssetSource('sounds/tap.mp3'));
    } catch (e) {
      print('Sound error: $e');
    }
  }
}
