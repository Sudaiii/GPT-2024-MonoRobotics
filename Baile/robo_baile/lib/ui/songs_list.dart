import 'package:flutter/material.dart';
import 'package:isolate_example/models/song.dart';

class SongList extends StatelessWidget {
  // final List<Song> items;

  // const SongList({super.key, required this.items});
  const SongList({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Lista canciones';
    final items = Song.songs;
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
            );
          },
        ),
      ),
    );
  }
}
