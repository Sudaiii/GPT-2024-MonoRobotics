import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robobaile/ui/MyApp.dart';
import 'package:robobaile/ui/music_player_state.dart';

class Abc extends StatefulWidget {
  const Abc({super.key});

  @override
  _Abc createState() => _Abc();
}

class _Abc extends State<Abc> {
  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);

    return GestureDetector(
      onTap: () {
        musicPlayerState.setFullScreenPlayerVisible(true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
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
