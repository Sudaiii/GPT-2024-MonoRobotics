import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robobaile/models/song.dart';
import 'package:robobaile/ui/MyApp.dart';
import 'package:robobaile/ui/music_player_state.dart';

class SongList extends StatefulWidget {
  List<Song> songs = [];

  SongList({super.key});

  static int selected = -1;

  @override
  _SongList createState() => _SongList();
}

class _SongList extends State<SongList> {
  // Fills list with songs, based on app configuration/memory
  Future _getSongs() async {
    widget.songs = [
      Song(
        songUrl: 'assets/audio/pixabay_audio.mp3',
        title: 'Song B',
        artist: 'Artist B',
      ),
      Song(
        songUrl: 'assets/audio/pixabay_audio.mp3',
        title: 'Song C',
        artist: 'Artist C',
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    if (widget.songs.isEmpty) {
      _getSongs();
    }
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Lista canciones';

    final items = widget.songs;

    return MaterialApp(
      title: title,
      home: Scaffold(
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildArtist(context),
              onTap: () {
                SongList.selected = index;
                final musicPlayerState = Provider.of<MusicPlayerState>(context, listen: false);
                musicPlayerState.playSong(item.title, item.artist, item.songUrl);
                musicPlayerState.setFullScreenPlayerVisible(true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

