import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerState extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  String currentSongTitle = '';
  String currentArtist = '';
  bool isFullScreenPlayerVisible = false;

  void playSong(String title, String artist, String songUrl) async {
    currentSongTitle = title;
    currentArtist = artist;
    await player.setUrl(songUrl);
    player.play();
    isPlaying = true;
    notifyListeners();
  }

  void togglePlayPause() {
    if (isPlaying) {
      player.pause();
    } else {
      player.play();
    }
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void setFullScreenPlayerVisible(bool isVisible) {
    isFullScreenPlayerVisible = isVisible;
    notifyListeners();
  }
}
