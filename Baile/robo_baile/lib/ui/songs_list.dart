import 'dart:io' show File, Platform;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:robobaile/models/song.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class SongList extends StatefulWidget {
  List<Song> songs = [];
  late Widget _child = Container();
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
//método para agregar una nueva canción a la lista
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
    Widget? _child; // Variable para manejar el estado
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
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.audio,
                    allowMultiple: false,
                  );
                  if (result != null) {
                    final filePath = result.files.single.path;
                    print('Ruta archivo: $filePath');
                    await MetadataRetriever.fromFile(File(filePath!))
                        .then((metadata) async {
                      String title =  metadata.trackName ?? "MISSING TITLE";
                      String artist = metadata.authorName ?? "MISSING AUTHOR";
                      Uint8List? image = metadata.albumArt;
                      print(title);
                      print(artist);
                      print(filePath);
                      Song newSong = Song(
                        songUrl: filePath,
                        title: title,
                        artist: artist,
                        image: image,
                      );
                      // Add the new song to the list
                      addSong(newSong);
                    }).catchError((_) {
                      // Actualizar el estado de _child
                      setState(() {
                        widget._child = const Text('No se pudieron extraer los metadatos');
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