import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:robobaile/models/song.dart';

class MusicPlayerState extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  String currentSongTitle = '';
  String currentArtist = '';
  String currentSongUrl = '';
  bool isFullScreenPlayerVisible = false;
  List<Song> songs = [];
  int currentIndex = -1;

  void playSong(String title, String artist, String songUrl) async {
    currentSongTitle = title;
    currentArtist = artist;
    currentSongUrl = songUrl;
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

  void stopPlaying() {
    player.stop();
    isPlaying = false;
    notifyListeners();
  }

  void setFullScreenPlayerVisible(bool isVisible) {
    isFullScreenPlayerVisible = isVisible;
    notifyListeners();
  }

  void playNext() {
    if (currentIndex < songs.length - 1) {
      currentIndex++;
      playSong(songs[currentIndex].title, songs[currentIndex].artist, songs[currentIndex].songUrl);
    }
  }

  void playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      playSong(songs[currentIndex].title, songs[currentIndex].artist, songs[currentIndex].songUrl);
    }
  }

  void addSong(Song newSong) {
    songs.add(newSong);
    notifyListeners();
  }

  void setSongs(List<Song> newSongs) {
    songs = newSongs;
    notifyListeners();
  }
}
