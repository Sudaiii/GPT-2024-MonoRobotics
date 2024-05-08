import 'package:flutter/material.dart';
import 'package:robobaile/models/song.dart';


class SongList extends StatefulWidget {
  List<Song> songs = [];

  SongList({super.key});

  static int selected = -1;

  @override
  _SongList createState() => _SongList();
}


class _SongList extends State<SongList>{

  // Fills list with songs, based on app configuration/memory
  Future _getSongs() async {
    widget.songs = [
      // await Song.fromUrl("song"),
      Song(
          songUrl: 'teeest',
          title: 'Song B',
          artist: 'Artist B'
      ),
      Song(
          songUrl: 'test',
          title: 'Song C',
          artist: 'Artist C'
      )
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
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
                title: item.buildTitle(context),
                subtitle: item.buildArtist(context),
                onTap: () {
                  SongList.selected = index;
                  //play_selected(index)
                }
            );
          },
        ),
      ),
    );
  }
}
