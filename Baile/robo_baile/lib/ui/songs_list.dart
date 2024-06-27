// ui/song_list.dart
import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:provider/provider.dart';
import 'package:robobaile/models/song.dart';
import 'package:robobaile/ui/music_player_state.dart';
import 'package:robobaile/ui/music_player.dart';

class SongList extends StatefulWidget {
  List<Song> songs = [];
  SongList({super.key});

  static int selected = -1;

  @override
  _SongList createState() => _SongList();
}

class _SongList extends State<SongList> {
  Future _getSongs() async {
    widget.songs = [
      Song(songUrl: 'assets/audio/pixabay_audio.mp3', title: 'Song B', artist: 'Artist B'),
      Song(songUrl: 'assets/audio/pixabay_audio.mp3', title: 'Song C', artist: 'Artist C'),
    ];
  }

  void addSong(Song newSong) {
    setState(() {
      widget.songs.add(newSong);
    });
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
    final title = 'Lista canciones';
    final items = widget.songs;

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio, allowMultiple: false);
                  if (result != null) {
                    final filePath = result.files.single.path;
                    print('Ruta archivo: $filePath');
                    await MetadataRetriever.fromFile(File(filePath!)).then((metadata) {
                      String title = metadata.trackName ?? "MISSING TITLE";
                      String artist = metadata.authorName ?? "MISSING AUTHOR";
                      Uint8List? image = metadata.albumArt;
                      print(title);
                      print(artist);
                      print(filePath);
                      Song newSong = Song(songUrl: filePath, title: title, artist: artist, image: image);
                      addSong(newSong);
                    }).catchError((_) {
                      setState(() {
                        // Handle error
                      });
                    });
                  }
                },
                child: const Text('Agregar Canción'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

