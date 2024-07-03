import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:robobaile/ui/music_player_state.dart';

class FullScreenPlayer extends StatelessWidget {
  const FullScreenPlayer({super.key});

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
            width: 350,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: MusicPlayer(
              songTitle: musicPlayerState.currentSongTitle,
              artist: musicPlayerState.currentArtist,
              isPlaying: musicPlayerState.isPlaying,
              togglePlayPause: musicPlayerState.togglePlayPause,
              player: musicPlayerState.player,
              onNext: musicPlayerState.playNext,
              onPrevious: musicPlayerState.playPrevious,
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
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const MusicPlayer({
    required this.songTitle,
    required this.artist,
    required this.isPlaying,
    required this.togglePlayPause,
    required this.player,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          songTitle,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          artist,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: IconButton(
            iconSize: 50,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: togglePlayPause,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.skip_previous),
              onPressed: onPrevious,
            ),
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.skip_next),
              onPressed: onNext,
            ),
          ],
        ),
        const SizedBox(height: 30),
        StreamBuilder<Duration?>(
          stream: player.positionStream,
          builder: (context, snapshot) {
            return ProgressBar(
              barHeight: 8,
              thumbRadius: 10,
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

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  _MiniPlayer createState() => _MiniPlayer();
}

class _MiniPlayer extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
          musicPlayerState.togglePlayPause();
        } else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          musicPlayerState.stopPlaying();
        }
      },
      onTap: () {
        musicPlayerState.setFullScreenPlayerVisible(true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FullScreenPlayer(),
          ),
        );
      },
      child: Container(
        color: Colors.grey[200],
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(musicPlayerState.currentSongTitle),
            IconButton(
              icon: Icon(
                musicPlayerState.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: musicPlayerState.togglePlayPause,
            ),
          ],
        ),
      ),
    );
  }
}
