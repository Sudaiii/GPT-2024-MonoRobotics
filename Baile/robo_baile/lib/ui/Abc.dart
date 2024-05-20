// abc.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robobaile/ui/music_player_state.dart';
import 'package:robobaile/ui/MyApp.dart';

class Abc extends StatefulWidget {
  const Abc({Key? key}) : super(key: key);

  @override
  _Abc createState() => _Abc();
}

class _Abc extends State<Abc> {
  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0 || details.primaryVelocity! < 0) {
          // Detener la canción y ocultar el mini reproductor
          musicPlayerState.stopSong();
        }
      },
      onTap: () {
        // Mostrar el reproductor grande y ocultar el mini reproductor
        musicPlayerState.setFullScreenPlayerVisible(true);
        Navigator.push(
          context,
             MaterialPageRoute(
               builder: (context) => MyApp(),
          ),
        );
      },
      child: Container(
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      musicPlayerState.currentSongTitle,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      musicPlayerState.currentArtist,
                      style: TextStyle(
                          fontSize: 14.0, color: Colors.yellow[700]),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.pink, width: 2.0),
                ),
                child: IconButton(
                  icon: musicPlayerState.isPlaying
                      ?  Icon(Icons.pause, color: Colors.pink)
                      :  Icon(Icons.play_arrow, color: Colors.pink),
                  onPressed: () {
                    if (musicPlayerState.isPlaying) {
                      musicPlayerState.pauseSong();
                    } else {
                      musicPlayerState.playSong(
                          musicPlayerState.currentSongTitle,
                          musicPlayerState.currentArtist,
                          musicPlayerState.currentArtist//_currentSongUrl
                      );

                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

