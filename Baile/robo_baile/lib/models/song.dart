import 'package:flutter/material.dart';

class Song {
  final String songUrl;
  final String title;
  final String artist;

  Song({required this.songUrl, required this.title, required this.artist});

  Widget buildTitle(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget buildArtist(BuildContext context) {
    return Text(artist, style: const TextStyle(fontSize: 16));
  }
}


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

