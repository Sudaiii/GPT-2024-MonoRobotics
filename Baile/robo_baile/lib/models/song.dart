// song.dart
import 'dart:typed_data';

class Song {
  final String songUrl;
  final String title;
  final String artist;
  final Uint8List? image;

  Song({
    required this.songUrl,
    required this.title,
    required this.artist,
    this.image,
  });

  Widget buildTitle(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget buildArtist(BuildContext context) {
    return Text(artist, style: const TextStyle(fontSize: 16));
  }
}
