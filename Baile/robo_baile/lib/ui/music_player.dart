// ui/music_player.dart
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:robobaile/ui/music_player_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            musicPlayerState.setFullScreenPlayerVisible(false);
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pinkAccent, Colors.blueAccent],
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 500,
            color: Colors.white.withOpacity(0.5),
            child: MusicPlayer(
              songTitle: musicPlayerState.currentSongTitle,
              artist: musicPlayerState.currentArtist,
              isPlaying: musicPlayerState.isPlaying,
              togglePlayPause: musicPlayerState.togglePlayPause,
              player: musicPlayerState.player,
            ),
          ),
        ),
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  final String songTitle;
  final String artist;
  final bool isPlaying;
  final VoidCallback togglePlayPause;
  final AudioPlayer player;

  const MusicPlayer({
    required this.songTitle,
    required this.artist,
    required this.isPlaying,
    required this.togglePlayPause,
    required this.player,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.network(
            'URL de la foto de la canción',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          songTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          artist,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: togglePlayPause,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: () {
                // Logic to play previous song
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {
                // Logic to play next song
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        StreamBuilder<Duration?>(
          stream: player.positionStream,
          builder: (context, snapshot) {
            return ProgressBar(
              progress: snapshot.data ?? Duration.zero,
              buffered: player.bufferedPosition,
              total: player.duration ?? Duration.zero,
              onSeek: (duration) {
                player.seek(duration);
              },
            );
          },
        ),
      ],
    );
  }
}