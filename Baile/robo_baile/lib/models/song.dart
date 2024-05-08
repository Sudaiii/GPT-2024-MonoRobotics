import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:path_provider/path_provider.dart';


class Song {
  String songUrl;
  String title;
  String artist;
  Uint8List? image;

  Song({
    required this.songUrl,
    required this.title,
    required this.artist,
    this.image,
  });

  // static Future<Song> fromUrl(String songUrl) async {
  //   List<Directory>? externalStorageDir = await getExternalStorageDirectories();
  //   if (externalStorageDir != null) {
  //     // Loads song from songUrl
  //     String musicPath = '${externalStorageDir[0]}/Music/song.mp3';
  //     File musicFile = File(musicPath);
  //     if (await musicFile.exists()) {
  //       // Uses metadata to fill song information
  //       final metadata = await MetadataRetriever.fromFile(File(songUrl));
  //       String title = await metadata.trackName ?? "MISSING TITLE";
  //       String artist = metadata.albumArtistName ?? "MISSING ARTIST";
  //       Uint8List? image = metadata.albumArt;
  //       print(title);
  //       return Song(
  //           songUrl: songUrl,
  //           title: title,
  //           artist: artist,
  //           image: image
  //       );
  //     } else {
  //       print('File does not existt');
  //     }
  //   } else {
  //     print('Could not access external storage directory');
  //   }
  //
  //   return Song(
  //       songUrl: 'teeest',
  //       title: 'Song A',
  //       artist: 'Artist A'
  //   );
  // }

  Widget buildTitle(BuildContext context) => Text(title);
  Widget buildArtist(BuildContext context) => Text(artist);

}