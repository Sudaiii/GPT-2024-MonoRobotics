// music_player_state.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerState with ChangeNotifier {
  bool _isPlaying = false;
  bool _isFullScreenPlayerVisible = false;
  String _currentSongTitle = '';
  String _currentArtist = '';
  String _currentSongUrl = '';//"assets/audio/pixabay_audio.mp3"

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool get isPlaying => _isPlaying;
  bool get isFullScreenPlayerVisible => _isFullScreenPlayerVisible;
  String get currentSongTitle => _currentSongTitle;
  String get currentArtist => _currentArtist;

  void playSong(String title, String artist, String url) {
    _currentSongTitle = title;
    _currentArtist = artist;
    _currentSongUrl = url;
    _isPlaying = true;
    _audioPlayer.play(UrlSource(url));
    notifyListeners();
  }

  void pauseSong() {
    _isPlaying = false;
    _audioPlayer.pause();
    notifyListeners();
  }

  void stopSong() {
    _isPlaying = false;
    _currentSongTitle = '';
    _currentArtist = '';
    _currentSongUrl = '';
    _audioPlayer.stop();
    notifyListeners();
  }

  void setFullScreenPlayerVisible(bool isVisible) {
    _isFullScreenPlayerVisible = isVisible;
    notifyListeners();
  }
}

