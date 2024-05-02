class Song {
  final String id;
  final String artist;
  final String title;
  final String songImageUrl;
  final String songUrl;

  Song({
    this.id = '',
    required this.artist,
    required this.title,
    required this.songImageUrl,
    required this.songUrl,
  });

  static List<Song> songs= [
    Song(
      id: '1',
      artist: 'Artist A',
      title: 'Song A',
      songImageUrl: 'URL',
      songUrl: 'test'
    ),
    Song(
        id: '2',
        artist: 'Artist B',
        title: 'Song B',
        songImageUrl: 'URL',
        songUrl: 'test'
    ),
    Song(
        id: '3',
        artist: 'Artist C',
        title: 'Song C',
        songImageUrl: 'URL',
        songUrl: 'test'
    )
  ];
}