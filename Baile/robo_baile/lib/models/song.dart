// song.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'dart:io';

class Song {
final String songUrl;
final String title;
final String artist;
Uint8List? image;

Song({
required this.songUrl,
required this.title,
required this.artist,
this.image,
});

Widget buildTitle(BuildContext context) => Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
Widget buildArtist(BuildContext context) => Text(artist, style: const TextStyle(fontSize: 16));
}