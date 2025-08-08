import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playTap() async {
    try {
      await _audioPlayer.stop(); // Stop any current playback
      await _audioPlayer.play(AssetSource('sounds/tap.mp3'));
    } catch (e) {
      // Consider using a logger in production
      print('Sound error: $e');
    }
  }

  static void dispose() {
    _audioPlayer.dispose();
  }
}
