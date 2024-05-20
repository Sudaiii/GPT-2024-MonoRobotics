// myApp.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robobaile/ui/music_player_state.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);

    return WillPopScope(
      onWillPop: () async {
        musicPlayerState.setFullScreenPlayerVisible(false);
        return true;
      },
      child: Scaffold(
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
              //child: MusicPlayer(
                //songTitle: musicPlayerState.songTitle,
                //artist: musicPlayerState.artist,
                //sPlaying: musicPlayerState.isPlaying,
                //togglePlayPause: musicPlayerState.togglePlayPause,
              //),
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

  const MusicPlayer({
    required this.songTitle,
    required this.artist,
    required this.isPlaying,
    required this.togglePlayPause,
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
                // Lógica para reproducir la canción anterior
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {
                // Lógica para reproducir la siguiente canción
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text('00:00'), // Temporizador
            /*Slider(
              value: 0.5, // Valor de ejemplo
              onChanged: (newValue) {
                Text('logica'),// Lógica para cambiar el tiempo de reproducción
              },
            ),*/
            Text('03:45'), // Duración de la canción
          ],
        ),
      ],
    );
  }
}
