import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:provider/provider.dart';
import 'package:robobaile/models/song.dart';
import 'package:robobaile/ui/music_player.dart';
import 'package:robobaile/ui/music_player_state.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  static int selected = -1;

  @override
  _SongList createState() => _SongList();
}

class _SongList extends State<SongList> {
  @override
  void initState() {
    super.initState();
    final musicPlayerState = Provider.of<MusicPlayerState>(context, listen: false);
    musicPlayerState.addListener(() {
      setState(() {
        // Trigger rebuild when musicPlayerState changes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Lista canciones';
    final musicPlayerState = Provider.of<MusicPlayerState>(context);
    final songs = musicPlayerState.songs;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final item = songs[index];
                    return ListTile(
                      title: item.buildTitle(context),
                      subtitle: item.buildArtist(context),
                      onTap: () {
                        SongList.selected = index;
                        musicPlayerState.playSong(item.title, item.artist, item.songUrl);
                        musicPlayerState.setFullScreenPlayerVisible(true);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const FullScreenPlayer()));
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
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
                            musicPlayerState.addSong(newSong);
                          }).catchError((_) {
                            setState(() {
                              // Handle error
                            });
                          });
                        }
                      },
                      child: const Text('Agregar Canción'),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Seleccionar Tipo de Baile'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: const Text('Baile 1'),
                                    onTap: () {
                                      // Handle Baile 1 selection
                                      Navigator.of(context).pop();
                                      _showDanceOptions(context, 'Baile 1');
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Baile 2'),
                                    onTap: () {
                                      // Handle Baile 2 selection
                                      Navigator.of(context).pop();
                                      _showDanceOptions(context, 'Baile 2');
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Baile 3'),
                                    onTap: () {
                                      // Handle Baile 3 selection
                                      Navigator.of(context).pop();
                                      _showDanceOptions(context, 'Baile 3');
                                    },
                                  ),
                                  // Add more dance types here
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Seleccionar Tipo de Baile'),
                    ),
                  ],
                ),
              ),
              if (musicPlayerState.isPlaying && !musicPlayerState.isFullScreenPlayerVisible)
                const SizedBox(height: 60), // Espacio para el MiniPlayer
            ],
          ),
          if (musicPlayerState.isPlaying && !musicPlayerState.isFullScreenPlayerVisible)
            const Align(
              alignment: Alignment.bottomCenter,
              child: MiniPlayer(),
            ),
        ],
      ),
    );
  }

  void _showDanceOptions(BuildContext context, String danceType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opciones para $danceType'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Opción 1'),
                onTap: () {
                  // Handle Option 1
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Opción 2'),
                onTap: () {
                  // Handle Option 2
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Opción 3'),
                onTap: () {
                  // Handle Option 3
                  Navigator.of(context).pop();
                },
              ),
              // Add more options here
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
