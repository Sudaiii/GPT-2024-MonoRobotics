// main.dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:robobaile/ui/song_list.dart';
import 'package:robobaile/ui/device_list.dart';
import 'package:robobaile/ui/music_player_state.dart';
import 'package:robobaile/bluetooth/manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupWindow();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicPlayerState(),
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}

const double windowWidth = 1024;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Robobaile');
    setWindowMinSize(const Size(windowWidth, windowHeight));
  }
}

class HomePage extends StatefulWidget {
  final BluetoothManager manager = BluetoothManager();
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);

    return MaterialApp(
      theme: ThemeData.light(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.music_note, color: Colors.green), text: 'Música'),
                Tab(icon: Icon(Icons.settings), text: 'Configuración'),
              ],
            ),
            title: const Text('Robobaile'),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  SongList(),
                  DeviceList(manager: widget.manager),
                ],
              ),
              if (musicPlayerState.isPlaying && !musicPlayerState.isFullScreenPlayerVisible)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MusicPlayer(
                    songTitle: musicPlayerState.currentSongTitle,
                    artist: musicPlayerState.currentArtist,
                    isPlaying: musicPlayerState.isPlaying,
                    togglePlayPause: musicPlayerState.togglePlayPause,
                    player: musicPlayerState.player,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
