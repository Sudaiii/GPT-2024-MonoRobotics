// main.dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robobaile/ui/Abc.dart';
import 'package:robobaile/ui/music_player_state.dart';
import 'package:robobaile/ui/song_list.dart';
import 'package:robobaile/ui/config.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicPlayerState(),
      child: const MaterialApp(
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);

    return MaterialApp(
      theme: ThemeData.light(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: musicPlayerState.isFullScreenPlayerVisible
              ? null
              : AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.music_note, color: Colors.green),
                  text: 'Música',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Configuración',
                ),
                Tab(
                  icon: Icon(Icons.bluetooth, color: Colors.blue),
                  text: 'Bluetooth',
                ),
              ],
            ),
            title: const Text('Robobaile'),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  SongList(),
                  const Config(),
                  const Config(), // Opción de Bluetooth
                ],
              ),
              if (musicPlayerState.isPlaying &&
                  !musicPlayerState.isFullScreenPlayerVisible)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Abc(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
